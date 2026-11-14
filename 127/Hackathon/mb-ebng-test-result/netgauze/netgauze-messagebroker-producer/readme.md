## YANG Message Broker Producer - Message and YANG Schema Production

Producer: `TelemetryKafkaYang` endpoint of the same `netgauze-collector` process, NetGauze 0.14 (see
`../netgauze-yangpush-receiver/config-lab.yaml`): topic `telemetry-message-yang-ebng`, schema registry
`http://localhost:8081`, `subject_prefix: lab`, root schema `ietf-telemetry-message` (revision 2026-10-25), Kafka
message key = publisher IP (`127.0.0.62`), schema id in the `schema-id` header. Log: `collector.log` in
`../netgauze-yangpush-receiver/ebng-netgauze-receiver-log.tar.gz`.

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
grep -c 'Message delivered successfully to kafka' collector.log      # 24818
grep -c 'using default schema ID' collector.log                      # 0
grep 127.0.0.62 collector.log | grep -c schemaID                     # 24812
grep 127.0.0.62 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
```
24,818 messages delivered (first 10:35:23.451, last 10:45:22.024 UTC), one per validated notification, for all 44
subscriptions; none with the default schema, no delivery error.

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```
schema_id=616  content_id="453f4d25..."  24,753 messages  subscriptions 1-4, 101, 200-205, 208-220, 301-304, 400-403
schema_id=625  content_id="8c492dc8..."      17 messages  subscriptions 104, 105, 106, 405
schema_id=628  content_id="afbee089..."      22 messages  subscriptions 206, 207
schema_id=631  content_id="ba7855ef..."      22 messages  subscriptions 300, 306
schema_id=634  content_id="3f7191b4..."       1 message   subscription 100
schema_id=638  content_id="83e6ed2e..."       3 messages  subscriptions 102, 305, 404
```
Full content ids: receiver readme. The grep lists 42 subscriptions and 24,812 lines: the first message of each content
id triggers the registration of its library and logs no `Found schemaID` line. That hides subscription 100 (one
message, schema id 634) and subscription 102 (its `subscription-terminated` is the first message of `83e6ed2e...`);
both are in the consumer log.

### Schema registration
```bash
grep -c 'registered schema' collector.log                                                  # 3551, registry ids 1-638
grep 'registered schema ietf-telemetry-message with subject' collector.log | grep -v 'ID `Some(78)`'
```
Each library is registered once, when the first validated notification of its content id is produced, as a new version
of subject `labietf-telemetry-message` that references the library's modules: version 4 = 616 (10:35:23.339 UTC, 14 s
after the first validated notification), 5 = 625 (10:35:28), 6 = 628 (10:36:09), 7 = 631 (10:36:10), 8 = 634
(10:45:21) and 9 = 638 (10:45:22). The last two appear at the end of the replay because subscriptions 100, 102, 305
and 404 only have their `subscription-terminated` validated. Versions 1-3 (ids 34, 36, 78) are the telemetry-message
schema without a device library; no message uses them.

### Examples - Message and Validation State for Each YANG-Push Subscription ID
```
2026-11-10T10:35:23.338956Z  INFO netgauze_netconf_proto::yanglib: registered schema ietf-telemetry-message with subject `Some("labietf-telemetry-message")`, version `Some(4)` and ID `Some(616)`
2026-11-10T10:35:23.339966Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=127.0.0.62 subscription_id=2 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-manage:bras-user-manage/access-tables/access-table/access-user-basic-info } schema_id=616 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
2026-11-10T10:35:23.451478Z TRACE netgauze_collector::publishers: Message delivered successfully to kafka
```
The produced messages are the `yp-sNNN-<type>.json` examples in `../netgauze-yangpush-receiver/`.
