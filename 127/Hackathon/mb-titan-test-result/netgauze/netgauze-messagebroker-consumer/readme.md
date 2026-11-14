## YANG Message Broker Consumer - Message and YANG Schema Consumption

Consumer: `kafka-yang-consumer` (NetGauze 0.14 example binary), strict anydata validation (`-A`), started after the
producer settled and reading the topic from the oldest offset:

```bash
RUST_LOG=kafka_yang_consumer=trace,info kafka-yang-consumer -b localhost:9092 -s http://localhost:8081 \
  --group lab-netgauze-<timestamp> -t telemetry-message-yang-titan -o oldest --cache-root-path kafka-yang-consumer-cache -f -A
```

Logs: `titan-netgauze-mb-consumer-log.tar.gz` (`titan-netgauze-mb-consumer-log.txt`, device messages, key
`127.0.0.123`; the `Message Payload` lines are left out) and `titan-netgauze-mb-consumer-log-mockups.tar.gz`
(`titan-netgauze-mb-consumer-log-mockups.txt`, key `192.0.2.222`).

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
grep -a 'Message validation' titan-netgauze-mb-consumer-log.txt | sed -E 's/.*Message validation ([A-Z]+) \[.*key: "?([0-9a-f.:]+)"?, schema_id: ([0-9]+)\].*/\2 \3 \1/' | sort | uniq -c
grep -a 'Message validation FAILED' titan-netgauze-mb-consumer-log.txt | sed -E 's/.*schema_id: ([0-9]+)\]: ?/\1 /' | sort | uniq -c | sort -rn
grep -a -o 'Fetched schema ID [0-9]*' titan-netgauze-mb-consumer-log.txt | sort -u | wc -l     # 288
```
| Schema id | Subscriptions | PASSED | FAILED |
|----------:|---------------|-------:|-------:|
| 79  | 82 | 8 | 0 |
| 82  | 85 | 8 | 0 |
| 85  | 81 | 8 | 0 |
| 89  | 86 | 8 | 0 |
| 101 | 88 | 8 | 0 |
| 103 | 83, 84 | 2 | 0 |
| 106 | 87 | 8 | 0 |
| 111 | 89-93 | 40 | 0 |
| 115 | 94 | 1 | 0 |
| 308 | 1-6, 11-16, 23, 25, 27 | 168 | 0 |
| 311 | 17-22 | 33 | 0 |
| **Total** | 35 | **292** | **0** |

292 device messages received (offsets 0-291), 11 schema ids, 288 schemas fetched from the registry, none failed. The
consumer's own statistics, mockups included: `Total messages processed: 301`, `Passed: 292`, `Failed: 9` (the
mockups), `Context errors: 0`, `No schema-id (skipped): 0`.
All 292 device messages pass: 35 subscription-started, one per subscription (matched by offset against the message
payloads the consumer prints), 250 push-update and 7 push-change-update. The device sends

```
"ietf-yang-push-revision:module-version":[{"module-name":"Cisco-IOS-XR-procmem-oper","revision":"2025-04-01"}]
```
as `ietf-yang-push-revision@2025-04-05` in its library defines it (`list module-version { key "module-name"; ... }`),
and the message on Kafka has the same entry: the collector re-encodes the notification from its typed model and keeps
the leaf names it received. NetCalyx 0.4.0 writes

```
"ietf-yang-push-revision:module-version":[{"name":"Cisco-IOS-XR-procmem-oper","revision":"2025-04-01"}]
```
(`name` is the leaf name of the current draft), which the device's revision in the registry does not have, so its
consumer rejects the 35 subscription-started with `Node "name" not found as a child of "module-version" node.`; so did
NetGauze before the fix these tests led to. NetCalyx's consumer passes 243: it also lacks the 14 push-updates of
subscriptions 85 and 88 that NetCalyx drops at reassembly.

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
tar -tzf titan-netgauze-mb-consumer-cache-content.tar.gz | grep '\.yang$' | awk -F/ '{n[$(NF-2)]++} END{for(k in n) print k, n[k]}' | sort -t- -k3 -n
schema-id-79 55      schema-id-101 64      schema-id-115 56
schema-id-82 55      schema-id-103 54      schema-id-308 245
schema-id-85 55      schema-id-106 55      schema-id-311 247
schema-id-89 56      schema-id-111 57
```
Each directory holds the modules of the device library plus the telemetry-message modules
(`ietf-telemetry-message@2026-10-25.yang`, `ietf-yang-push-telemetry-message@2026-10-25.yang`).

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID
```
DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 0, key: "127.0.0.123", schema_id: 79]
DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 22, key: "127.0.0.123", schema_id: 308]
```
One example message per subscription and notification type: `../netgauze-yangpush-receiver/yp-sNNN-<type>.json`.

### Example Mockup Logs - Message and Validation State for Each Telemetry Message Validation Test Case
N/A for this device: the nine `mb-test-cases/fano-yp1-tm-ietf-interfaces-*.json` messages are FANO payloads, produced
here with schema id 308 (IOS XR library of subscription 1) and key `192.0.2.222`. All nine fail (0 passed):

| Offset | Test case | Result |
|-------:|-----------|--------|
| 292 | valid | FAILED: `Node "interfaces" not found in the "ietf-interfaces" module.` |
| 293 | invalid1-yang-8791structure-structurename-1level | FAILED: `Node "messages" not found in the "ietf-telemetry-message" module.` |
| 294 | invalid2-yang-8791structure-structurename-2level | FAILED: `Node "envelopes" not found in the "ietf-yp-notification" module.` |
| 295 | invalid3-yang-7950schema-leafname-1level | FAILED: `Node "ids" not found as a child of "yang-push-subscription" node.` |
| 296 | invalid4-yang-7950schema-containername-2level | FAILED: `Node "interface" not found in the "ietf-interfaces" module.` |
| 297 | invalid5-yang-7950schema-leafcontent-1level | FAILED: `Invalid non-number-encoded uint32 value "a".` |
| 298-300 | invalid6, invalid7, invalid8 | FAILED: `Node "interfaces" not found in the "ietf-interfaces" module.` |

The valid message and invalid6-8 stop at `/if:interfaces`, which the IOS XR library deviates as not-supported
(`cisco-xr-ietf-interfaces-deviations@2025-03-06`); the errors of invalid1-5 name the node or value the test case alters.
