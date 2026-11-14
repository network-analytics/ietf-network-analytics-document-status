## YANG Message Broker Consumer - Message and YANG Schema Consumption

Consumer: `kafka-yang-consumer` of NetGauze 0.14, started after the replay on a new consumer group, reading the topic
from the oldest offset with strict anydata validation (`-A`):
```bash
RUST_LOG=kafka_yang_consumer=trace,info kafka-yang-consumer -b localhost:9092 -s http://localhost:8081 \
  --group lab-netgauze-<epoch> -t telemetry-message-yang-bns -o oldest --cache-root-path kafka-yang-consumer-cache -f -A
```
Logs (message payload lines removed): `bns-netgauze-mb-consumer-log.tar.gz` (device messages, key `127.0.0.58`) and
`bns-netgauze-mb-consumer-log-mockups.tar.gz` (mockups, key `192.0.2.222`).

### Search Log - Consume Messages and Filter by YANG-Push Publisher IP Address
```bash
grep -a "Message validation" bns-netgauze-mb-consumer-log.txt | sed -E 's/.*Message validation ([A-Z]+) \[.*key: "?([0-9a-f.:]+)"?, schema_id: ([0-9]+)\].*/\2 \3 \1/' | sort | uniq -c
```
| Key          | Schema id | Subscriptions | Messages | PASSED | FAILED |
|--------------|-----------|---------------|----------|--------|--------|
| `127.0.0.58` | 62        | 100, 101      | 8        | 8      | 0      |
| `127.0.0.58` | 64        | 104           | 1        | 1      | 0      |
| `127.0.0.58` | 67        | 102, 103      | 9        | 9      | 0      |
| `127.0.0.58` | 188       | 106           | 7        | 7      | 0      |
| total        |           |               | 25       | 25     | 0      |

All 25 produced messages (offsets 0-24) are received and validated; every subscription has at least one PASSED
message. The consumer's own statistics: 34 processed, 25 passed, 9 failed (the nine mockups below), 0 context errors,
0 without `schema-id`. NetCalyx 0.4.0 gives the same 25 PASSED / 0 FAILED on the same inputs.

### List Cache Directories - All YANG Schema ID's being used for serialization
`bns-netgauze-mb-consumer-cache-content.tar.gz`: one directory per schema id found in a `schema-id` header, with the
modules fetched from the schema registry (164 distinct schema ids fetched, none failed).

| Directory       | Module files | Content                                                              |
|-----------------|--------------|----------------------------------------------------------------------|
| `schema-id-62`  | 37           | library `2ec7d285...` (`ietf-interfaces`) + 3 envelope modules       |
| `schema-id-64`  | 38           | library `add0a8f1...` (`ietf-alarms`) + 3 envelope modules           |
| `schema-id-67`  | 39           | library `6bd32376...` (`ietf-hardware`) + 3 envelope modules         |
| `schema-id-188` | 158          | library `848fd359...` (6WIND `vrouter-*`) + 3 envelope modules       |

The envelope modules are `ietf-telemetry-message@2026-10-25`, `ietf-yang-push-telemetry-message@2026-10-25` and
`ietf-platform-manifest@2026-06-27`. `ietf-inet-types` and `ietf-yang-types` are fetched as `@2021-02-22` and
`@2013-07-15` (schema ids 5 and 6), where the device library lists `@2025-12-22` as import-only; the same is
observed with NetCalyx 0.4.0.

### Example Logs - Notifications and Validation State for Each YANG Schema ID
```
2026-11-10T12:18:38.059866Z  INFO kafka_yang_consumer: Creating new YANG context for schema ID: 62
2026-11-10T12:18:38.330891Z  INFO kafka_yang_consumer: Successfully created YANG context for schema ID: 62
2026-11-10T12:18:38.331084Z DEBUG kafka_yang_consumer: Message validation PASSED [partition: 0, offset: 0, key: "127.0.0.58", schema_id: 62]
2026-11-10T12:18:40.645767Z  INFO kafka_yang_consumer: Successfully created YANG context for schema ID: 188
```

### Example Mockup Logs - Mockup Telemetry Messages and Validation State
N/A for this device: the nine `../../../mb-test-cases/*.json` messages are FANO (Huawei OLT) telemetry messages. They
were produced with `tools/produce-mockups.sh` and schema id 62 (no subscription 1 in this capture, so the first schema
id of the run), key `192.0.2.222`, offsets 25-33. 0 PASSED, 9 FAILED:

| Offset | Mockup            | Error text                                                             |
|--------|-------------------|------------------------------------------------------------------------|
| 25     | valid             | `No module named "huawei-interface-statistics-mgt" in the context.`    |
| 26     | invalid1          | `Node "messages" not found in the "ietf-telemetry-message" module.`    |
| 27     | invalid2          | `Node "envelopes" not found in the "ietf-yp-notification" module.`     |
| 28     | invalid3          | `Node "ids" not found as a child of "yang-push-subscription" node.`    |
| 29     | invalid4          | `Node "interface" not found in the "ietf-interfaces" module.`          |
| 30     | invalid5          | `Invalid non-number-encoded uint32 value "a".`                         |
| 31-33  | invalid6, 7, 8    | `No module named "huawei-interface-statistics-mgt" in the context.`    |

The valid message and invalid6-8 fail only because the Huawei module of their payload is not in the 6WIND library;
invalid1-5 fail on the defect their file name describes. NetCalyx 0.4.0 also fails all nine (schema id 65); six
error texts differ (`Node "system" not found as a child of "data-collection-manifest" node.`) because it validates
against `ietf-telemetry-message@2025-10-19`.
