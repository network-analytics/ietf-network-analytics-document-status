## YANG Message Broker Producer - Message and YANG Schema Production

Producer: `TelemetryKafkaYang` endpoint of the same `netgauze-collector` process (NetGauze 0.14, see
`../netgauze-yangpush-receiver/config-lab.yaml`): topic `telemetry-message-yang-bns`, schema registry
`http://localhost:8081`, `subject_prefix: lab`, root schema `ietf-telemetry-message` (revision 2026-10-25), Kafka
message key = publisher IP (`127.0.0.58`), Kafka header `schema-id`. Log: `collector.log` in
`../netgauze-yangpush-receiver/bns-netgauze-receiver-log.tar.gz`.

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
grep -c "Message delivered successfully to kafka" collector.log      # 25
grep -c "Error sending message to Kafka" collector.log               # 0
grep -c "using default schema ID" collector.log                      # 0
grep -c "registered schema" collector.log                            # 312 (188 distinct schema ids, 1..188)
grep -cE "Failed to register|status code 4[0-9][0-9]" collector.log  # 0 (no 409 Conflict, no 422)
grep 127.0.0.58 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
```
All 25 validated notifications are delivered, one message each; the 2 rejected push-updates (100, 104) are not
produced.

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```
subscription_id=101 schema_id=62 content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86"
subscription_id=102 schema_id=67 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=103 schema_id=67 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=106 schema_id=188 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"
```
`Found schemaID` is logged when a content id is already registered (21 lines). The first message of each content id
registers the library instead; 100 and 104 produce only that one message (their subscription-started), so their
schema id is taken from the `schema-id` header of the consumed message:

| Subscription | Schema id | Content id                                                         | Messages delivered               |
|--------------|-----------|--------------------------------------------------------------------|----------------------------------|
| 100          | 62        | `2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86` | 1 (subscription-started)         |
| 101          | 62        | `2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86` | 7 (1 + 6 push-updates)           |
| 102          | 67        | `6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8` | 2 (1 + 1 push-update)            |
| 103          | 67        | `6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8` | 7 (1 + 6 push-updates)           |
| 104          | 64        | `add0a8f1059c582885e01df79e854f768477c3515f684c0d1c43fb54b325c3ba` | 1 (subscription-started)         |
| 106          | 188       | `848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c` | 7 (1 + 6 push-updates)           |

### Schema registration
Every module of the four libraries registers without a retry, the 6WIND `vrouter-*` modules included
(`vrouter-extensions` id 69, `vrouter-aaa` id 118). Ids 1-36 are the collector's default telemetry-message libraries,
registered at start-up. The root schema of each device library is a new version of subject
`labietf-telemetry-message`:

| Content id    | Root schema id | Subject version | New schema ids | Registered at (UTC) |
|---------------|----------------|-----------------|----------------|---------------------|
| `2ec7d285...` | 62             | 3               | 26             | 12:16:45.996        |
| `add0a8f1...` | 64             | 4               | 2              | 12:16:46.402        |
| `6bd32376...` | 67             | 5               | 3              | 12:16:46.502        |
| `848fd359...` | 188            | 6               | 121            | 12:16:49.832        |

### Examples - Message and Validation State for Each YANG-Push Subscription ID
```
2026-11-10T12:16:49.832626Z  INFO netgauze_netconf_proto::yanglib: registered schema ietf-telemetry-message with subject `Some("labietf-telemetry-message")`, version `Some(6)` and ID `Some(188)`
2026-11-10T12:16:46.502707Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=127.0.0.58 subscription_id=102 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware } schema_id=67 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
2026-11-10T12:16:46.105643Z TRACE netgauze_collector::publishers: Message delivered successfully to kafka
```
The 25 deliveries are logged between 12:16:46.105 and 12:17:02.799. The produced messages are consumed and validated
in `../netgauze-messagebroker-consumer/readme.md`.
