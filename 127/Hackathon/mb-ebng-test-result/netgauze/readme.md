## Test Result Summary for YANG Message Broker Consumer Integration Testing

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
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed (see note 1)   |
| Consumer        | NetGauze     | Verify that Mockup Telemetry Messages are validated                                | N/A (see note 3)      |

### Test Result Comments for YANG Message Broker Consumer Integration Testing

**Test run:** 2026-11-10, single host, loopback. NetGauze 0.14 collector (`udp_notif.anydata_strict_validation: true`)
and `kafka-yang-consumer -A`; Confluent Platform 7.8.0 in docker with yang-schema-registry-plugin 0.0.6-7.4 (registry
heap `-Xms18192M -Xmx52768M`, `-Dyang.hotfix.skip-reference-parsing=true`, 16 MB record limit), recreated empty before
the run (`docker/docker-compose.kafka.yml`). Huawei NE8000 eBNG capture
`ipt-lss923-a-mbi-05--yp-udpnotif-20261009-1357.pcap`: 37,337 packets, 24,998 complete notifications, 44 subscriptions
sharing 6 YANG libraries, 613 s. The device sends ~34,600 packets in the first 30 s (~5,000 packets/s peak), so the
capture is replayed in real time (`tools/replay-udp-notif.py`); NetGauze received all of it with zero kernel drops and
no pause. How to reproduce: `mb-test-setup/readme.md` (`tools/prepare-lab.sh`, `tools/run-all.sh ebng`,
`tools/package-results.sh ebng <run-dir>`).

**Totals:** receiver received 24,998 notifications: 24,818 validated (24,773 push-update, 1 push-change-update, 44
subscription-terminated), 0 skipped, 177 rejected, 3 undecodable. Producer delivered 24,818 messages for all 44
subscriptions under 6 schema ids (616, 625, 628, 631, 634, 638), none with the default schema. Consumer: 24,818 device
messages, 24,818 passed, 0 failed; mockups 0 passed, 9 failed.

**Note 1 - rejected notifications (device issues).** Every subscription has its `subscription-terminated` validated,
produced and consumed, but subscriptions 100, 101, 102, 104, 305, 403 and 404 have no validated data notification
(subscription 4 sent none). NetCalyx 0.4.0 rejects the same 177 notifications with the same errors.

```
subscription  type                 count  libyang error
all 44        subscription-started    44  Node "datastore" not found as a child of "subscription-started" node.
100           push-change-update      45  Invalid identityref "linkDown" value - identity not found in module "ietf-alarms".
101           push-change-update      22  Node "interface" not found in the "ietf-yang-push" module.
101           push-update              1  Unsatisfied length - string "" length is not allowed.
102           push-change-update      13  Node "component" not found in the "ietf-yang-push" module.
102, 404      push-update         2 + 18  Node "physical-index" not found as a child of "component" node.
105           push-change-update       2  Node "remote-systems-data" not found in the "ietf-yang-push" module.
305           push-update             10  Node "hardware" not found in the "ietf-yang-push" module.
403           push-update             20  Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to map prefix to YANG schema.
```
* `subscription-started`: the NE8000 library deviates `/sn:subscription-started/sn:target` as not-supported while the
  device still sends `ietf-yang-push:datastore`. The subscription is registered anyway and its data is validated.
* 100: alarm identities sent without module name and defined by no module of the library (10 values, `linkDown` 23x).
* 101, 102, 105 push-change-update: the yang-patch edit `value` holds `"interface"` / `"component"` /
  `"remote-systems-data"`, a node below the schema root without module name (in Swisscom's list: "libyang, anydata
  validation does not cover instance data not being encoded from the schema root").
* 101 push-update: `"description": ""` while the Huawei deviation restricts the leaf to `length "1..242"`.
* 102, 404: `physical-index` is `if-feature entity-mib`; the library advertises no feature for `ietf-hardware`.
* 305: `datastore-contents` holds `"hardware"` without module name (Swisscom: Huawei VRP R026C00, issue 37).
* 403: `iana-if-type:ethernetCsmacd` (10) and `iana-if-type:ppp` (10); `iana-if-type` is not in the YANG library.

**Note 2 - undecodable notifications (device issue).** Three push-updates are not valid JSON: subscriptions 104 and
105 (LLDP, raw CR/LF inside a `system-description` string) and 102 (`ietf-hardware`, `"urn:clei:\0"`). Both collectors
drop them with the same JSON error, see the receiver readme. It is the only push-update subscription 104 sends.

**Note 3 - mockups not applicable.** The mockups are FANO telemetry messages; produced with schema id 616 (NE8000
library) all nine fail, the valid one with `No module named "huawei-interface-statistics-mgt" in the context.`

### Cross-check with NetCalyx 0.4.0

Same capture, receiver cache content, Kafka and Schema Registry setup (topic `telemetry-message-yang-ebng-netcalyx`);
Swisscom's published result is `../netcalyx/readme.md`.

|                          | NetGauze 0.14        | NetCalyx 0.4.0 run locally      | Swisscom `../netcalyx/readme.md`    |
|--------------------------|----------------------|---------------------------------|-------------------------------------|
| Receiver validated       | 24,818               | 24,816                          | not reported                        |
| Receiver rejected        | 177 (+3 undecodable) | 177 (+3 undecodable)            | not reported (100, 101, 305, 403, 404 listed as known issues) |
| Producer delivered       | 24,818               | 24,816                          | not reported                        |
| Consumer passed / failed | 24,818 / 0           | 24,816 / 0                      | not reported                        |
| Wall time                | 766 s                | 859 s (includes the 90 s pause) | not reported                        |

The verdicts are identical: Swisscom's table has the same two "Failed" rows (it has no mockup row), and the local
NetCalyx run rejects the same 177 + 3 notifications and uses the same six schema ids. The count differs by two
push-updates of subscription 2 (message ids 49 and 2154 of the stream to 138.187.58.51) that never reach NetCalyx's
validation: the two segments of 2154 are the packets just before and just after the 90 s pause its replay needs
(`--warmup-gap 90`), and 49 arrives while NetCalyx resolves the first subscriptions (its log has no line for it).
NetGauze validates both.

NetGauze builds one libyang context per content id (6) off the async runtime: all 44 subscriptions are resolved 1.4 s
after the first `subscription-started`. NetCalyx resolves the 44 subscriptions one at a time, about 1.15 s apart
(50 s) and does not read its socket meanwhile, hence the pause: replayed without it, NetCalyx loses 16,420 of the
37,337 datagrams in the kernel and validates 9,625 notifications. NetGauze produces `ietf-telemetry-message@2026-10-25`, NetCalyx 0.4.0 `2025-10-19`.
