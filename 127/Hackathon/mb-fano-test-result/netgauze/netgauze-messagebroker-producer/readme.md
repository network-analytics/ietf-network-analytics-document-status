## YANG Message Broker Producer - Message and YANG Schema Production

Producer: `TelemetryKafkaYang` endpoint of the same `netgauze-collector` process, NetGauze 0.14 (see
`../netgauze-yangpush-receiver/config-lab.yaml`): topic `telemetry-message-yang`, schema registry
`http://localhost:8081`, `subject_prefix: lab`, root schema `ietf-telemetry-message@2026-10-25`. Kafka message key =
publisher IP address, header `schema-id`. Log: `../netgauze-yangpush-receiver/fano-netgauze-receiver-log.tar.gz`.

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
grep -c 'Message delivered successfully to kafka' collector.log    # 7298
grep -c 'using default schema ID' collector.log                    # 0
grep 127.0.0.79 collector.log | grep -c schemaID                   # 7295
```
Every validated notification is produced: 7,298 messages for 27 subscriptions, all with the schema id of the
subscription's YANG library, none with the default schema. Subscriptions 7, 9, 11 and 27 produce only their
`subscription-started` (their data notifications are rejected by the receiver).

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 127.0.0.79 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n

subscription_id=1..5, 12..26  schema_id=391 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=6..11         schema_id=390 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=27            schema_id=399 content_id="f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521"
```
The output has one line per subscription (condensed here). The `Found schemaID` line is logged when the schema id of
a content id is already known; the first message of each content id is produced right after the registration and has
no such line (7,295 lines for 7,298 messages). The only message of subscription 27 is such a first message, so its
schema id comes from the registration line and from the consumer:
```bash
grep 'registered schema ietf-telemetry-message ' collector.log | sed -E 's/.*(version.*)/\1/' | awk '!seen[$0]++'

version `Some(1)` and ID `Some(34)`      # registered at startup, not used by any message
version `Some(2)` and ID `Some(36)`      # registered at startup, not used by any message
version `Some(3)` and ID `Some(193)`     # 4 references, logged before each device schema, not used by any message
version `Some(4)` and ID `Some(390)`     # content id 53af9564...
version `Some(5)` and ID `Some(391)`     # content id 38ef2138...
version `Some(6)` and ID `Some(399)`     # content id f0961ff3...
```
Messages per subscription (`messages@schema_id`):
```
 1:327@391   2:42@391   3:43@391   4:43@391   5:6121@391   6:219@390   7:1@390    8:44@390    9:1@390
10:43@390   11:1@390   12:45@391  13:44@391  14:44@391    15:22@391   16:109@391  17:109@391  18:21@391
19:3@391    20:3@391   21:2@391   22:2@391   23:2@391     24:2@391    25:2@391    26:2@391    27:1@399
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID
```
2026-11-10T13:33:39.355630Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=127.0.0.79 subscription_id=7 router_content_id="22934" target={...} schema_id=390 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
```
