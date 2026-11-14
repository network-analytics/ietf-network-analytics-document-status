## FANO Blueplanet Integration Test Results

Evidence collected from **10.190.33.167** on **2026-11-06**. Receiver and producer:
NetCalyx 0.3.0; topic: `telemetry-yang`; broker: `10.190.33.167:9092`;
YANG Schema Registry: `http://10.190.33.167:8081`. Both connections are plaintext.

| Component | Test | Result |
| --- | --- | --- |
| Receiver | Prepared FANO YANG cache and matching replay peer address | Passed |
| Publisher | PCAP replay sends notifications | Partial: replay observed; full capture completion not established |
| Receiver | Notifications received for subscriptions 1-27 | Passed: all IDs occur in exported Kafka records |
| Receiver | At least one valid data notification for every subscription | Not fully verified; receiver validation failures recorded |
| Producer | At least one message for each subscription | Passed: all 27 IDs present; this includes subscription-started messages |
| Schema Registry | Obtain all schema IDs used by exported records and their references | Passed: IDs 983, 985, 993 and 363 referenced versions exported |
| Blueplanet consumer | Receive all subscription messages | Partial: Nov 10 run logged 1,180 records across IDs 1-27; full Kafka offset-range reconciliation was not done |
| Blueplanet consumer | Obtain all necessary YANG schemas | Partial: registry schemas loaded; subscription-started module-version entries fail the v2 `module-name` key check |
| Blueplanet consumer | Validate push-update data for every subscription | Partial: 1,026/1,153 push updates passed; 127 failed strict parsing/validation |
| Blueplanet consumer | Validate valid/invalid mock telemetry fixtures | Not verified |

### Evidence Index

- [Receiver cache, notification samples, and validation logs](netcalyx-yangpush-receiver/readme.md)
- [PCAP replay configuration and saved replay logs](netcalyx-yangpush-publisher/readme.md)
- [Produced messages and subscription/schema coverage](netcalyx-messagebroker-producer/readme.md)
- [Schema Registry export](yang-schema-registry/readme.md)
- [Blueplanet consumer procedure and separately labelled NetCalyx reference evidence](blueplanet-messagebroker-consumer/readme.md)
- [Machine-readable collection summary](evidence-summary.json)

### Measured Results and Limitations

The server collection analyzed **11,452 FANO records**, partition 0, offsets
**1525-12976**. Only the coverage summary and 50 first-observed subscription/type
examples are retained in this folder, not the full Kafka-record archive.
The collection includes several replay runs and the manually republished
subscription-5 record at offset 12976; it is not a unique-message count or
evidence of one uninterrupted full-PCAP run.

A separate **NetCalyx reference consumer** sample of 100 messages had **73 pass**,
**27 fail**, and **zero schema-context errors**. These are not Blueplanet results.
The 27 failures concern `module-version.name` in captured subscription-started
payloads. Receiver logs also contain invalid union/decimal64 transceiver values.
Neither captures nor schema validation were weakened to conceal failures.

The Blueplanet Java consumer was subsequently run on **2026-11-10** using JAR
MD5 `60a14301979a3284cbdeb4ce4f6de9b5`. Its log contains **1,180 messages**:
**1,026 consumed and 154 failed**. All **27 subscription-started** control
messages failed because their `ietf-yang-push-revision:module-version` entries
use `name` while the referenced YANG-Push Revision v2 schema requires
`module-name`. Among the **1,153 push updates**, **1,026 passed and 127 failed**.
Subscriptions 1-4 still omit mandatory `if:discontinuity-time`; subscriptions
6, 8, and 10 contain identity values rejected by the registered `sub-class`
identityref; and extra subscriptions 19, 21, and 25 have missing port-reference/
statistics or invalid board alarm-state data. See the [Blueplanet consumer
results](blueplanet-messagebroker-consumer/readme.md) for per-subscription counts.

The NetCalyx result folder contains another environment's schema IDs
236779/236780/236781. Do not substitute those IDs for this server's IDs.
Original publisher NETCONF XML and PCAP assets remain unchanged; the exported
receiver archive contains the server's rewritten `peer_ip` values.