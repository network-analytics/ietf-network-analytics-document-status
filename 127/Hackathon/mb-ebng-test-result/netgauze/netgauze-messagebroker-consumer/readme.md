## YANG Message Broker Consumer - Message and YANG Schema Consumption

Consumer: `kafka-yang-consumer` (example binary of NetGauze 0.14) run with `-A`, which validates the YANG-Push
notification inside the telemetry message strictly, like the receiver.

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
RUST_LOG=kafka_yang_consumer=trace,info kafka-yang-consumer -b localhost:9092 -s http://localhost:8081 \
    --group lab-netgauze-<ts> -t telemetry-message-yang-ebng -o oldest --cache-root-path kafka-yang-consumer-cache -f -A
# ebng-netgauze-mb-consumer-log.tar.gz: the log without "Message Payload [" lines and without the mockup key
grep -a 'Message validation' ebng-netgauze-mb-consumer-log.txt | sed -E 's/.*Message validation ([A-Z]+) \[.*key: "?([0-9a-f.:]+)"?, schema_id: ([0-9]+)\].*/\2 \3 \1/' | sort | uniq -c
  24753 127.0.0.62 616 PASSED
     17 127.0.0.62 625 PASSED
     22 127.0.0.62 628 PASSED
     22 127.0.0.62 631 PASSED
      1 127.0.0.62 634 PASSED
      3 127.0.0.62 638 PASSED
```
24,818 device messages consumed (offsets 0-24817), 24,818 PASSED, 0 FAILED, no WARN or ERROR line. Each message is
one notification validated by the receiver, so the per-subscription counts are those of the receiver readme;
subscriptions 4, 100, 101, 102, 104, 305, 403 and 404 only have their `subscription-terminated`.

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
tar -tzf ebng-netgauze-mb-consumer-cache-content.tar.gz    # schema-id-N/{yang-lib.xml,modules/,subscriptions-info.json}
schema-id-616   582 modules   content 453f4d25...  subscriptions 1-4, 101, 200-205, 208-220, 301-304, 400-403
schema-id-625   590 modules   content 8c492dc8...  subscriptions 104, 105, 106, 405
schema-id-628   584 modules   content afbee089...  subscriptions 206, 207
schema-id-631   584 modules   content ba7855ef...  subscriptions 300, 306
schema-id-634   584 modules   content 3f7191b4...  subscription 100
schema-id-638   585 modules   content 83e6ed2e...  subscriptions 102, 305, 404
grep -a -o -E 'Fetched schema ID [0-9]+' ebng-netgauze-mb-consumer-log.txt | sort -u | wc -l             # 605
grep -a -c 'Successfully created YANG context for schema ID' ebng-netgauze-mb-consumer-log.txt           # 6
```
Each directory holds the modules of the receiver cache for that content id plus `ietf-telemetry-message@2026-10-25`,
`ietf-yang-push-telemetry-message@2026-10-25` and `ietf-platform-manifest@2026-06-27`, with `ietf-inet-types` in
revision 2021-02-22 instead of 2013-07-15. One YANG context is built per schema id (6) and reused for its messages.

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID
```
2026-11-10T10:47:04.634987Z  INFO kafka_yang_consumer: Creating new YANG context for schema ID: 616
2026-11-10T10:47:08.341972Z  INFO kafka_yang_consumer: Successfully created YANG context for schema ID: 616
2026-11-10T10:47:08.342568Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 0, key: "127.0.0.62", schema_id: 616]
2026-11-10T10:47:28.491167Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 24817, key: "127.0.0.62", schema_id: 616]
```

### Example Mockup Logs - Message and Validation State for Each Telemetry Message Validation Test Case
Not applicable to this device: the nine `mb-test-cases/fano-yp1-tm-ietf-interfaces-*.json` are FANO messages, produced
here with `tools/produce-mockups.sh 616` (key `192.0.2.222`) against the NE8000 library. 0 PASSED, 9 FAILED
(`ebng-netgauze-mb-consumer-log-mockups.tar.gz`, offsets 24818-24826, in the order valid, invalid1 ... invalid8):
```
valid        No module named "huawei-interface-statistics-mgt" in the context.
invalid1     Node "messages" not found in the "ietf-telemetry-message" module.
invalid2     Node "envelopes" not found in the "ietf-yp-notification" module.
invalid3     Node "ids" not found as a child of "yang-push-subscription" node.
invalid4     Node "interface" not found in the "ietf-interfaces" module.
invalid5     Invalid non-number-encoded uint32 value "a".
invalid6-8   No module named "huawei-interface-statistics-mgt" in the context.
```
