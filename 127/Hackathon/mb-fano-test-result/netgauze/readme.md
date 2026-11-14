## Test Result Summary for YANG Message Broker Consumer Integration Testing

**Test run:** 2026-11-10, single host, loopback. NetGauze 0.14: `netgauze-collector` as YANG-Push receiver and message
broker producer (strict anydata validation, messages produced as `ietf-telemetry-message@2026-10-25`),
`kafka-yang-consumer -A` as consumer. Confluent Platform 7.8.0 with yang-schema-registry-plugin 0.0.6-7.4
(`docker/docker-compose.kafka.yml`), recreated empty before the run. FANO capture
`ipd-zbl1536-s-ah-79-yp-udpnotif-20261020-1651.pcap` (Huawei OLT `10.80.32.79`, 45,148 UDP-Notif packets, 27
subscriptions) replayed as `127.0.0.79` with traffic-reproducer at 20x. Wall time 456 s, no kernel UDP drops. How to
reproduce: [mb-test-setup/readme.md](../../mb-test-setup/readme.md) (`tools/prepare-lab.sh`, `tools/run-all.sh fano`,
`tools/package-results.sh fano <run-dir>`).

| Component       | Name         | Test Case                                                                          | Passed/Failed/Partial |
|-----------------|--------------|------------------------------------------------------------------------------------|-----------------------|
| Receiver        | NetGauze     | Verify YANG-Push Receiver Content                                                  | Passed                |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher                                    | Passed                |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions Notifications are received             | Passed                |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed (see note 1)   |
| Producer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Message is produced       | Passed                |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable        | Passed                |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions Messages are received                  | Passed                |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained          | Passed                |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed (see note 2)   |
| Consumer        | NetGauze     | Verify that Mockup Telemetry Messages are validated                                | Failed (see note 3)   |

### Test Result Comments for YANG Message Broker Consumer Integration Testing

**Totals:** receiver 7,746 notifications = 7,298 validated (27 subscription-started, 7,271 push-update) + 0 skipped +
448 rejected (431 push-update, 17 push-change-update); producer 7,298 messages delivered, all with a device schema id
(391: subscriptions 1-5, 12-26; 390: 6-11; 399: 27), 0 with the default schema; consumer 7,298 device messages, 7,298
passed and 0 failed; mockups 0 passed, 9 failed.

**Note 1 - receiver: subscriptions 7, 9, 11 and 27 have no validated data notification.** Their
`subscription-started` is validated, every data notification is rejected and dropped:

| Subscription | Rejected               | Error                                                              |
|--------------|------------------------|--------------------------------------------------------------------|
| 7            | 218 push-update        | `Invalid union value "-5000" - no matching subtype found:` (1)     |
| 9            | 171 push-update        | same, e.g. value `"579"`                                           |
| 11           | 42 push-update         | same, e.g. value `"1013"`                                          |
| 27           | 17 push-change-update  | `No module named "huawei-alarm-type-an" in the context.`           |

(1) followed by `ly2 enumeration: Invalid non-string-encoded enumeration value "-5000".` and `ly2 decimal64: Invalid
non-string-encoded decimal64 value "-5000".` Subscriptions 7, 9, 11 (`bbf-hardware-transceivers:transceiver-link`):
`power-dbm/transmit` and `receive` are a union of an enumeration and a `decimal64` (range -40..20); the device sends
bare JSON numbers such as `-5000` where RFC 7951 requires a string, and the values are outside the range. Subscription
27 (`/ietf-alarms:alarm-notification`): the payload uses `huawei-alarm-type-an`, which is in the device's YANG library
but not in the module set of the subscription (it announces only `ietf-alarms@2019-09-11`). Details in
`netgauze-yangpush-receiver/readme.md`. The other 23 subscriptions have no rejected notification.

**Note 2 - consumer: every device message passes; subscriptions 7, 9, 11 and 27 have no validated data message.**
All 7,298 messages pass: the 27 `subscription-started` and the 7,271 push-updates. For 7, 9, 11 and 27 the
`subscription-started` is the only message on the topic (note 1), hence "Failed", as for the receiver. The device
sends `module-version` entries keyed by `module-name` (its `ietf-yang-push-revision@2024-12-17`) and the collector
re-encodes them with the leaf names it received, so they validate against the device's revision in the registry. A
collector that writes the leaf `name` of the current draft instead has all 27 rejected with `Node "name" not found as
a child of "module-version" node.`: NetCalyx 0.4.0 does, and NetGauze did until the fix these tests led to (see the
[top-level readme](../../readme.md#what-the-tests-found)). Details in `netgauze-messagebroker-consumer/readme.md`.

**Note 3 - mockups: 9 of 9 rejected, including the valid one (test data issue).** The valid mockup fails with
`Invalid non-num64-encoded uint64 value "0".`: `mb-test-cases/` encodes the counter64 leaf
`huawei-interface-statistics-mgt:change-times` as a JSON number, RFC 7951 requires a string. invalid1 to invalid5 are
rejected for their intended defect; invalid6 to invalid8 stop at the same uint64 error as the valid one. Exact error
per mockup in `netgauze-messagebroker-consumer/readme.md`.

### Cross-check with NetCalyx 0.4.0

NetCalyx 0.4.0 was run on the same host with the same capture, cache content and a fresh Kafka and registry.

|                                 | NetGauze 0.14 | NetCalyx 0.4.0 (local) | Swisscom `../netcalyx/readme.md`         |
|---------------------------------|---------------|------------------------|------------------------------------------|
| Receiver validated / rejected   | 7,298 / 448   | 7,298 / 448            | not reported (7, 9, 11, 27 rejected)     |
| Producer delivered              | 7,298         | 7,298                  | not reported                             |
| Consumer passed / failed        | 7,298 / 0     | 7,271 / 27             | not reported                             |
| Mockups passed / failed         | 0 / 9         | 0 / 9                  | not tested                               |
| Wall time                       | 456 s         | 455 s                  | not reported                             |

The verdicts are identical, and so are the receivers: NetCalyx rejects the same 448 notifications (same message ids,
same errors) and delivers the same 7,298 messages; only the schema ids differ (389, 391, 399). The consumers differ by
the 27 `subscription-started` messages, which NetCalyx 0.4.0 re-encodes with `module-version/name` and its consumer
rejects (note 2); all 7,271 push-updates pass in both. Swisscom reports the same two "Failed" rows for the same
subscriptions (7, 9, 11: invalid union value; 27: push-change-update) and has no mockup row; its consumer log
(`../netcalyx/netcalyx-messagebroker-consumer/`) counts 7,395 passed / 27 failed, the 27 with the same
`Node "name" ...` error. The only other difference between the two local runs is the reason for six mockup failures:
NetCalyx 0.4.0 registers `ietf-telemetry-message@2025-10-19` and rejects the
valid mockup and invalid2, 4, 6, 7, 8 with `Node "system" not found as a child of "data-collection-manifest" node.`
