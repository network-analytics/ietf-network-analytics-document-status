## Test Result Summary for YANG Message Broker Consumer Integration Testing

**Test run:** 2026-11-10, single host, loopback. NetGauze 0.14 (collector with `anydata_strict_validation: true`,
`kafka-yang-consumer -A`), Confluent Platform 7.8.0 with yang-schema-registry-plugin 0.0.6-7.4, 16 MB record limit,
stack recreated empty before the run (`docker/docker-compose.kafka.yml`). Cisco IOS XR capture
`ipt-age923-b-aac-01-yp-udpnotif-202610261504.pcap` (6,075 UDP-Notif packets, 459 notifications, 35 subscriptions, one
UDP source port per subscription, 407.9 s) replayed in real time with `tools/replay-udp-notif.py`, which keeps the
original source ports. How to reproduce: [mb-test-setup/readme.md](../../mb-test-setup/readme.md).

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
| Consumer        | NetGauze     | Verify that Mockup Telemetry Messages are validated                                | N/A (see note 3)      |

### Test Result Comments for YANG Message Broker Consumer Integration Testing

Totals: receiver received 459 notifications (35 subscription-started, 278 push-update, 146 push-change-update), validated
292 (35 / 250 / 7), skipped 0, rejected 167 (28 push-update, 139 push-change-update); 35 cache hits, 0 misses. Producer
delivered 292 messages (35 subscriptions, 11 schema ids, no default-schema message). Consumer received 292 device
messages: 292 passed, 0 failed; mockups 0 of 9 passed. Wall time 520 s, no kernel UDP drops.

**Note 1 - rejected notifications (receiver, strict anydata validation).** All 35 subscription-started validate;
subscriptions 23, 25, 27, 83, 84 and 94 have no validated data notification, hence "Failed" (as in Swisscom's table).

| Subscription | Type               | Rejected | Error text                                                                   |
|--------------|--------------------|----------|------------------------------------------------------------------------------|
| 3            | push-update        | 7 of 21  | `Invalid union value "openconfig-platform-types:OPTICAL_CHANNEL" - no matching subtype found:` |
| 11           | push-change-update | 73 of 73 | `Node "state" not found in the "openconfig-interfaces" module.` (64), `Node "interface" not found ...` (9) |
| 15           | push-change-update | 4 of 8   | `Node "state" not found in the "openconfig-lldp" module.`                      |
| 19           | push-change-update | 3 of 6   | `Node "state" not found in the "openconfig-lacp" module.`                      |
| 21           | push-change-update | 11 of 11 | `Node "member" not found in the "openconfig-lacp" module.`                     |
| 23           | push-change-update | 4 of 4   | `Node "adjacencies" not found in the "openconfig-network-instance" module.`    |
| 25           | push-change-update | 20 of 20 | `Node "state" not found in the "openconfig-network-instance" module.`          |
| 27           | push-change-update | 24 of 24 | `Node "alarms" not found in the "openconfig-system" module.`                   |
| 83, 84       | push-update        | 7 of 7 each | `Node "policy-timestamp" not found as a child of "statistics" node.`        |
| 94           | push-update        | 7 of 7   | `Invalid enumeration value "selection -point".`                                |

* Subscription 3 (device issue, not in Swisscom's list): the component `OpticalChannel0/0/0/0` is sent with
  `"type":"openconfig-platform-types:OPTICAL_CHANNEL"`; the identity is defined in `openconfig-transport-types`, so
  libyang adds `Invalid identityref ... identity not found in module "openconfig-platform-types".` These are the seven
  91-segment messages (ids 3, 6, ..., 21); the other 14 push-updates of the subscription validate.
* Subscriptions 11, 15, 19, 21, 23, 25, 27: all 139 rejected push-change-updates carry a YANG-Patch edit whose `value`
  is the target node itself (e.g. `{"openconfig-lldp:state":{...}}` for a target ending in `/state`), not data encoded
  from the schema root: 126 `replace` edits, 13 `delete` edits with a value (23, 27). The 7 validated ones (15, 19) are
  `delete` edits without a value. Swisscom lists 11, 21, 23, 25, 27: "libyang, anydata validation does not cover
  instance data not being encoded from the schema root" (CSCws28882 for 23, 25, 27); 15 and 19 are not in its list.
* Subscriptions 83, 84: `policy-timestamp` is in no module of the device's library. Subscription 94: the device sends
  `"stream-type":"selection -point"` (with a space), the enum is `selection-point`. Both are in Swisscom's list.

**Note 2 - consumer.** Every message passes: 35 subscription-started, 250 push-update, 7 push-change-update.
Subscriptions 23, 25, 27, 83, 84 and 94 have no data message on the topic (note 1), hence "Failed", as for the
receiver. The device sends `"ietf-yang-push-revision:module-version":[{"module-name":...,"revision":...}]`, as its
`ietf-yang-push-revision@2025-04-05` defines it, and the collector re-encodes the notification with the leaf names it
received. A collector that writes the leaf `name` of the current draft instead has all 35 subscription-started
rejected with `Node "name" not found as a child of "module-version" node.`: NetCalyx 0.4.0 does, and NetGauze did
until the fix these tests led to (see the [top-level readme](../../readme.md#what-the-tests-found)).

**Note 3 - mockups.** The nine `mb-test-cases/*.json` messages are FANO payloads; here they are produced with schema
id 308 (the IOS XR library of subscription 1), so the test does not apply. All nine fail, the valid one with
`Node "interfaces" not found in the "ietf-interfaces" module.` (see the consumer readme).

### Cross-check with NetCalyx 0.4.0

Same capture, YANG libraries, registry setup and host; NetCalyx needs `--warmup-gap 90` (a 90 s pause after the
subscription-started burst), NetGauze runs without a pause. Swisscom's `../netcalyx/readme.md` reports verdicts only.

|                               | NetGauze 0.14 | NetCalyx 0.4.0 (local)                | Swisscom `../netcalyx/` |
|-------------------------------|---------------|---------------------------------------|-------------------------|
| Receiver validated / rejected | 292 / 167     | 278 / 160, 21 dropped at reassembly   | not reported            |
| Producer delivered            | 292           | 278                                   | not reported            |
| Consumer passed / failed      | 292 / 0       | 243 / 35                              | not reported            |
| Wall time                     | 520 s         | 607 s (includes the 90 s pause)       | not reported            |

The verdicts of the nine rows Swisscom reports are identical (the two "at least one Notification is validated" rows
Failed, the rest Passed), and the 438 notifications both receivers decode get the same verdict and error text. The
receiver counts differ by exactly the 21 notifications of more than 64 UDP-Notif segments, which NetCalyx 0.4.0 drops:
167 vs 160 rejected (+7, subscription 3) and 292 vs 278 validated and delivered (+14, subscriptions 85 and 88, which
have no data message with NetCalyx). At the consumer NetGauze passes 292 and NetCalyx 243: the same 14 messages, plus
the 35 subscription-started that NetCalyx re-encodes with `module-version/name` (note 2).

```
WARN netcalyx_udp_notif_service::actor: [Actor 1-127.0.0.1:8123] dropping packet due to an error in decoding packet peer=127.0.0.123:37756 error=Segment reassembly error: UDP-Notif reassembly aborted: publisher-id=0, message-id=3 exceeded the maximum allowed segment count of 64
```

| Subscription (source port) | Messages          | Segments each | NetGauze 0.14                        | NetCalyx 0.4.0 |
|----------------------------|-------------------|---------------|--------------------------------------|----------------|
| 3 (37756)                  | ids 3, 6, ..., 21 | 91            | 7 rejected (OPTICAL_CHANNEL, note 1) | 7 dropped      |
| 85 (46007)                 | ids 1-7           | 416-420       | 7 validated, delivered, passed       | 7 dropped      |
| 88 (56278)                 | ids 1-7           | 92            | 7 validated, delivered, passed       | 7 dropped      |
