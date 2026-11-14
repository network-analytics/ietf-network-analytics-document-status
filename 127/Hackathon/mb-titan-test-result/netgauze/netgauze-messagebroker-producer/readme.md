## YANG Message Broker Producer - Message and YANG Schema Production

Producer: NetGauze 0.14 `TelemetryKafkaYang` publisher (same `netgauze-collector` process as the receiver), topic
`telemetry-message-yang-titan`, registry `http://localhost:8081`, subject prefix `lab`, root schema
`ietf-telemetry-message` (revision 2026-10-25), Kafka message key = publisher address `127.0.0.123`. Configuration:
`../netgauze-yangpush-receiver/config-lab.yaml`; log: `collector.log` in
`../netgauze-yangpush-receiver/titan-netgauze-receiver-log.tar.gz`.

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
grep -c 'Message delivered successfully to kafka' collector.log          # 292
grep 127.0.0.123 collector.log | grep -c 'Found schemaID'                # 281
grep -c 'using default schema ID' collector.log                          # 0
grep -c 'Failed to register' collector.log                               # 0
```
```
TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=127.0.0.123 subscription_id=83 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: Cisco-IOS-XR-qos-ma-oper:qos/interface-table/interface/input/service-policy-names/service-policy-instance/statistics } schema_id=94 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"
TRACE netgauze_collector::publishers: Message delivered successfully to kafka
```
All 292 validated notifications are delivered (35 subscription-started, 250 push-update, 7 push-change-update), every
one with the schema id of its subscription's YANG library. The first message of each of the 11 content ids registers
the library and logs no `Found schemaID` line (292 - 11 = 281).

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 127.0.0.123 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
```
| Subscriptions | Schema id | Content id | Messages delivered |
|---------------|----------:|------------|-------------------:|
| 1-6, 11-16, 23, 25, 27 | 308 | `4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08` | 168 |
| 17-22 | 311 | `c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01` | 33 |
| 81 | 85 | `ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3` | 8 |
| 82 | 79 | `369536a436f0d21eabc81ef220e3fca8ac933c667eb26937ef05fb4d499c6fed` | 8 |
| 83, 84 | 103 | `0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114` | 2 |
| 85 | 82 | `8a199e95f7dc22c9d48e427d76647fd6dd56e046501b2370d76c03d573eda4c3` | 8 |
| 86 | 89 | `9b24ab29c609d764dff3c5d9b7326056a7bcb9e680be565b9f2d15fca86e1b00` | 8 |
| 87 | 106 | `da952479f7ed21edea0aa95fec17fdc2eb1622954201c5216bbd12655a44c287` | 8 |
| 88 | 101 | `1c5665b1bda78f76baaec1afe3db9eb491af2d770ecc678d9b2fbf3bb4dec5cf` | 8 |
| 89-93 | 111 | `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 40 |
| 94 | 115 | `7d667a00976c1fe2f927b065214b45bc398f2192bd05572e424a60d12e3ed0f9` | 1 |

The command lists 33 subscriptions and 10 schema ids. Subscriptions 84 and 94 are missing from it because their only
validated notification (subscription-started) is the first message of its content id; both are on the topic (schema
ids 103 and 115, see the consumer readme), so all 35 subscriptions and 11 schema ids are produced. Messages per schema
id are the consumer's counts.

Subscriptions 85 and 88 include their seven push-updates of 416-420 and 92 UDP-Notif segments (about 590 kB and 130 kB
of JSON each); NetCalyx 0.4.0 drops these 14 at reassembly and delivers 278 messages.
