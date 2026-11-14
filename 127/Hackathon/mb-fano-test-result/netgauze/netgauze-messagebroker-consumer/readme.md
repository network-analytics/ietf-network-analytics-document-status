## YANG Message Broker Consumer - Message and YANG Schema Consumption

Consumer: `kafka-yang-consumer` (example binary of the NetGauze collector crate), NetGauze 0.14, started with `-A`
(strict anydata validation) after the producer has settled.

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
RUST_LOG=kafka_yang_consumer=trace,info kafka-yang-consumer -b localhost:9092 -s http://localhost:8081 \
    --group lab-netgauze-<ts> -t telemetry-message-yang -o oldest --cache-root-path kafka-yang-consumer-cache -f -A
# packaged log: timestamped lines only, without the "Message Payload [" lines, split by Kafka message key
tar -xzf fano-netgauze-mb-consumer-log.tar.gz             # fano-netgauze-mb-consumer-log.txt          key 127.0.0.79
tar -xzf fano-netgauze-mb-consumer-log-mockups.tar.gz     # fano-netgauze-mb-consumer-log-mockups.txt  key 192.0.2.222
grep -a 'Message validation' fano-netgauze-mb-consumer-log.txt | sed -E 's/.*Message validation ([A-Z]+) \[.*key: "?([0-9a-f.:]+)"?, schema_id: ([0-9]+)\].*/\2 \3 \1/' | sort | uniq -c

    309 127.0.0.79 390 PASSED
   6988 127.0.0.79 391 PASSED
      1 127.0.0.79 399 PASSED
```
7,298 device messages consumed (offsets 0-7297): 7,298 PASSED, 0 FAILED.

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
tar -tzf fano-netgauze-mb-consumer-cache-content.tar.gz | grep '\.yang$' | cut -d/ -f2 | sort | uniq -c

    356 schema-id-390    # content id 53af9564..., subscriptions 6-11
    355 schema-id-391    # content id 38ef2138..., subscriptions 1-5, 12-26
    362 schema-id-399    # content id f0961ff3..., subscription 27
```
All three schemas and their references were obtained from the registry (no fetch error in the log).

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID
```bash
grep -a -c 'Message validation FAILED' fano-netgauze-mb-consumer-log.txt     # 0
```
Every message passes: the 27 `subscription-started`, one per subscription (offsets 0-18, 21, 22, 24, 25, 27, 28, 30,
31), and the 7,271 push-updates. PASSED per subscription (subscription id from the message payload), none FAILED:
```
 1: 327      2: 42       3: 43       4: 43       5: 6121     6: 219      7: 1        8: 44       9: 1
10: 43      11: 1       12: 45      13: 44      14: 44      15: 22      16: 109     17: 109     18: 21
19: 3       20: 3       21: 2       22: 2       23: 2       24: 2       25: 2       26: 2       27: 1
```
All 27 subscriptions have at least one PASSED message; for 7, 9, 11 and 27 it is the `subscription-started`, their
only message on the topic (the receiver rejects all their data notifications). The device sends
`"ietf-yang-push-revision:module-version":[{"module-name":...,"revision":...}]`, as defined by its
`ietf-yang-push-revision@2024-12-17` (`list module-version { key "module-name"; }`). The collector re-encodes the
notification from its typed model and keeps the leaf names it received, so the produced message carries the same
`module-name` entries (see `../netgauze-yangpush-receiver/yp-s001-subscription-started.json`) and validates against
the device's 2024-12-17 revision in the registry. NetCalyx 0.4.0 writes `[{"name":...,"revision":...}]`, the leaf name
of the current draft, and its consumer rejects the 27 messages with
`Node "name" not found as a child of "module-version" node.`; so did NetGauze before the fix these tests led to.
```
2026-11-10T13:40:41.032849Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 0, key: "127.0.0.79", schema_id: 390]
2026-11-10T13:40:41.663558Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 19, key: "127.0.0.79", schema_id: 391]
2026-11-10T13:40:42.273966Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 32, key: "127.0.0.79", schema_id: 390]
```

### Example Mockup Logs - Message and Validation State for Each Telemetry Message Validation Test Case
The nine `mb-test-cases/fano-yp1-tm-ietf-interfaces-*.json` messages, produced with `tools/produce-mockups.sh 391`
(schema id of subscription 1, key `192.0.2.222`) and consumed by the same consumer. All nine FAILED:
```
offset 7298  valid                                        Invalid non-num64-encoded uint64 value "0".
offset 7299  invalid1 8791structure-structurename-1level  Node "messages" not found in the "ietf-telemetry-message" module.
offset 7300  invalid2 8791structure-structurename-2level  Node "envelopes" not found in the "ietf-yp-notification" module.
offset 7301  invalid3 7950schema-leafname-1level          Node "ids" not found as a child of "yang-push-subscription" node.
offset 7302  invalid4 7950schema-containername-2level     Node "interface" not found in the "ietf-interfaces" module.
offset 7303  invalid5 7950schema-leafcontent-1level       Invalid non-number-encoded uint32 value "a".
offset 7304  invalid6 7950schema-leafcontent-2level       Invalid non-num64-encoded uint64 value "0".
offset 7305  invalid7 7950schema-leafmissing-1level       Invalid non-num64-encoded uint64 value "0".
offset 7306  invalid8 7950schema-leafmissing-2level       Invalid non-num64-encoded uint64 value "0".
```
invalid1 to invalid5 are rejected for the defect they were built with. The valid message is rejected because of the
test data: `huawei-interface-statistics-mgt:change-times` (`yang:counter64`) is encoded as a JSON number (47 x `0`,
1 x `7`) in its 48 interfaces, while RFC 7951 requires 64-bit integers as strings (the other counter64 leaves, e.g.
`in-octets`, are strings). invalid6 to invalid8 contain the same leaf and stop at the same error, so their own defect
(out-of-range `in-octets`, missing `notification-event`, missing interface `name`) is not reached.
