## YANG Message Broker Consumer - Message and YANG Schema Consumption

`kafka-yang-consumer` of NetGauze 0.14, started after the replay, reading the topic from the oldest offset with
strict anydata validation (`-A`). Logs: `alive-netgauze-mb-consumer-log.tar.gz` (device messages, without the
payload lines), `alive-netgauze-mb-consumer-log-mockups.tar.gz` (the nine mockup messages).

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
RUST_LOG=kafka_yang_consumer=trace,info kafka-yang-consumer -b localhost:9092 -s http://localhost:8081 \
  --group lab-netgauze-1794306096 -t telemetry-message-yang-alive -o oldest \
  --cache-root-path kafka-yang-consumer-cache -f -A

tar -xzf alive-netgauze-mb-consumer-log.tar.gz
grep -a 'Message validation' alive-netgauze-mb-consumer-log.txt | sed -E 's/.*Message validation ([A-Z]+) \[.*key: "?([0-9a-f.:]+)"?, schema_id: ([0-9]+)\].*/\2 \3 \1/' | sort | uniq -c
grep -a 'Message validation FAILED' alive-netgauze-mb-consumer-log.txt | sed -E 's/.*schema_id: ([0-9]+)\]: ?/\1 /' | sort | uniq -c | sort -rn
```

```
    351 ::1 36 FAILED
      4 ::1 36 PASSED
    166 ::1 624 PASSED
     82 ::1 627 PASSED
   1486 ::1 628 PASSED

    248 36 No module named "ietf-hardware" in the context.
     81 36 Node "hardware" not found in the "ietf-yang-push" module.
     22 36 No module named "ietf-alarms" in the context.
```

2,089 device messages (key `::1`, offsets 0-2088): 1,738 passed, 351 failed. With the nine mockups the consumer
statistics read `Total messages processed: 2098`, `Passed: 1738`, `Failed: 360`, `Context errors: 0`.

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
tar -tzf alive-netgauze-mb-consumer-cache-content.tar.gz | grep '/modules/.' | cut -d/ -f2 | sort | uniq -c
```

```
     35 schema-id-36
    590 schema-id-624
    584 schema-id-627
    582 schema-id-628
```

All four schema ids found in the message headers are fetched from the registry with their references (1,795 schema
fetches) and a YANG context is created for each (`Successfully created YANG context for schema ID: 36`, `624`, `627`,
`628`). Each directory holds `yang-lib.xml`, `subscriptions-info.json` and `modules/`.

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID
The subscription id is read from the message payload; the packaged log identifies messages by offset and schema id.

| Schema id | Subscription | Messages                                   | Passed | Failed | Error                                                    |
|-----------|--------------|--------------------------------------------|--------|--------|----------------------------------------------------------|
| 627       | 1            | 82 push-update                             | 82     | 0      |                                                          |
| 628       | 2            | 82 push-update                             | 82     | 0      |                                                          |
| 628       | 3            | 324 push-update                            | 324    | 0      |                                                          |
| 628       | 4            | 81 push-update                             | 81     | 0      |                                                          |
| 628       | 5            | 999 push-update                            | 999    | 0      |                                                          |
| 624       | 16           | 82 push-update                             | 82     | 0      |                                                          |
| 624       | 17           | 2 push-change-update                       | 2      | 0      |                                                          |
| 624       | 18           | 82 push-update                             | 82     | 0      |                                                          |
| 36        | 7            | 1 subscription-started, 81 push-update     | 1      | 81     | `Node "hardware" not found in the "ietf-yang-push" module.` |
| 36        | 13           | 1 subscription-started, 2 push-update      | 1      | 2      | `No module named "ietf-hardware" in the context.`        |
| 36        | 14           | 1 subscription-started, 246 push-update    | 1      | 246    | `No module named "ietf-hardware" in the context.`        |
| 36        | 19           | 1 subscription-started, 22 push-change-update | 1   | 22     | `No module named "ietf-alarms" in the context.`          |

Subscriptions 6, 11, 12 and 15 have no message in the topic (rejected or not decodable at the receiver). At least one
data notification is validated for subscriptions 1, 2, 3, 4, 5, 16, 17, 18 (8 of 16).

Schema id 36 is the default `ietf-telemetry-message` schema without device modules, used by the producer for the
four subscriptions that are not in the receiver cache. Their `subscription-started` pass because they contain only
nodes of modules that this schema includes (ietf-subscribed-notifications, ietf-yang-push, ietf-yang-push-revision,
ietf-distributed-notif); the data notifications fail because `ietf-hardware` and `ietf-alarms` are not in it. For
subscription 7 the device also encodes `"datastore-contents":{"hardware":{...}}` without the `ietf-hardware:` module
prefix, hence the different error.

```
2026-11-10T10:21:38.254676Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 0, key: "::1", schema_id: 36]
2026-11-10T10:21:41.972106Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 6, key: "::1", schema_id: 624]
2026-11-10T10:21:43.603829Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 12, key: "::1", schema_id: 627]
2026-11-10T10:21:45.191246Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 13, key: "::1", schema_id: 628]
2026-11-10T10:21:38.256483Z ERROR kafka_yang_consumer: Message validation FAILED [partition: 0, offset: 4, key: "::1", schema_id: 36]: No module named "ietf-hardware" in the context.
2026-11-10T10:21:41.972757Z ERROR kafka_yang_consumer: Message validation FAILED [partition: 0, offset: 7, key: "::1", schema_id: 36]: No module named "ietf-alarms" in the context.
2026-11-10T10:21:45.203264Z ERROR kafka_yang_consumer: Message validation FAILED [partition: 0, offset: 39, key: "::1", schema_id: 36]: Node "hardware" not found in the "ietf-yang-push" module.
```

NetCalyx 0.4.0, run locally on the same inputs, gives the same 1,738 passed / 351 failed with the same errors.

### Example Mockup Logs - Message and Validation State for Each Telemetry Message Validation Test Case
N/A for this device. The nine `../../../mb-test-cases/fano-yp1-tm-ietf-interfaces-*.json` messages are FANO payloads;
`tools/produce-mockups.sh` produces them with key `192.0.2.222` and the schema id of subscription 1 (627, NE8000).
All nine fail, the valid one because the FANO module `huawei-interface-statistics-mgt` is not in the NE8000 library.

```bash
tar -xzOf alive-netgauze-mb-consumer-log-mockups.tar.gz | sed -E 's/.*(offset: [0-9]+).*\]: /\1 /'
```

| Offset | Test case                                   | Result | Error                                                                |
|--------|---------------------------------------------|--------|----------------------------------------------------------------------|
| 2089   | valid                                       | FAILED | `No module named "huawei-interface-statistics-mgt" in the context.`  |
| 2090   | invalid1-yang-8791structure-structurename-1level | FAILED | `Node "messages" not found in the "ietf-telemetry-message" module.` |
| 2091   | invalid2-yang-8791structure-structurename-2level | FAILED | `Node "envelopes" not found in the "ietf-yp-notification" module.` |
| 2092   | invalid3-yang-7950schema-leafname-1level    | FAILED | `Node "ids" not found as a child of "yang-push-subscription" node.`  |
| 2093   | invalid4-yang-7950schema-containername-2level | FAILED | `Node "interface" not found in the "ietf-interfaces" module.`      |
| 2094   | invalid5-yang-7950schema-leafcontent-1level | FAILED | `Invalid non-number-encoded uint32 value "a".`                       |
| 2095   | invalid6-yang-7950schema-leafcontent-2level | FAILED | `No module named "huawei-interface-statistics-mgt" in the context.`  |
| 2096   | invalid7-yang-7950schema-leafmissing-1level | FAILED | `No module named "huawei-interface-statistics-mgt" in the context.`  |
| 2097   | invalid8-yang-7950schema-leafmissing-2level | FAILED | `No module named "huawei-interface-statistics-mgt" in the context.`  |
