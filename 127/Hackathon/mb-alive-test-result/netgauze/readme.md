## Test Result Summary for YANG Message Broker Consumer Integration Testing

| Component       | Name         | Test Case                                                                          | Passed/Failed/Partial      |
|-----------------|--------------|------------------------------------------------------------------------------------|----------------------------|
| Receiver        | NetGauze     | Verify YANG-Push Receiver Content                                                  | Partial, see note 1        |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher                                    | Passed                     |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions Notifications are received             | Passed, see note 2         |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed, see notes 1, 3, 4  |
| Producer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Message is produced       | Partial, see note 5        |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable        | Partial, see note 1        |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions Messages are received                  | Partial, see note 5        |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained          | Passed                     |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed, see note 6         |
| Consumer        | NetGauze     | Verify that Mockup Telemetry Messages are validated                                | N/A, see note 7            |

### Test Result Comments for YANG Message Broker Consumer Integration Testing

**Test run.** 2026-11-10, single host over loopback. NetGauze 0.14 (receiver with `anydata_strict_validation: true`,
consumer with `-A`), Confluent Platform 7.8.0 with yang-schema-registry-plugin 0.0.6-7.4 on an empty registry
(`../../docker/docker-compose.kafka.yml`). Capture
`netgauze-yangpush-publisher/ipf-zbl1327-r-daisy-48-yp-udpnotif-20260918-0847-vrf501.pcap` (Huawei NE8000,
`2001:db8:48::1` replayed as `::1`): 11,620 packets, 2,446 UDP-Notif messages, 16 subscriptions (1-7, 11-19), 4,943 s,
replayed 20x with traffic-reproducer in 248 s to `[::1]:8123`; topic `telemetry-message-yang-alive`. Whole run 372 s,
0 kernel UDP drops. How to reproduce: `../../mb-test-setup/readme.md` (`tools/run-all.sh alive`).

**Totals.** Receiver: 2,446 messages = 1,734 validated + 355 forwarded without validation (no schema) + 353 rejected
+ 4 not decodable. Producer: 2,089 delivered (1,734 with schema ids 624 / 627 / 628, 355 with the default schema id
36). Consumer: 2,089 device messages, 1,738 passed / 351 failed; 9 mockups, 0 passed / 9 failed.

1. **Receiver cache covers 12 of 16 subscriptions.**
   `netgauze-yangpush-receiver/alive-netgauze-receiver-cache-content.tar.gz` is the receiver cache Swisscom published
   (three content ids, peer remapped to `::1`). It has no entry for subscriptions 7, 13, 14
   (`/ietf-hardware:hardware/...`) and 19 (`/ietf-alarms:alarm-notification`). No NETCONF server exists in the lab, so
   the receiver has no schema for them, forwards their 355 notifications unvalidated and the producer publishes them
   with the default schema id 36 (`ietf-telemetry-message` without device modules). No device schema is registered
   for these four subscriptions; the libraries of the other 12 are registered as schema ids 624, 627, 628.
2. **Device sends invalid JSON (4 messages, not decodable).** All 16 subscriptions are received. Message ids 17
   (sub 15), 18 and 19 (sub 17): raw CR/LF inside the LLDP `system-description` string, `JSON error: control character
   (\u0000-\u001F) found while parsing a string`. Message id 23 (sub 13): `"uri":["urn:clei:\0",...]`, `JSON error:
   invalid escape`. All four are push-update; for sub 15 it is the only data notification in the capture.
3. **`subscription-started` rejected, 12 of 16 (subs 1-6, 11, 12, 15-18).** `Node "datastore" not found as a child of
   "subscription-started" node.` The device library contains
   `huawei-ietf-subscribed-notifications-deviations-NE8000-F1A@2025-02-24` with
   `deviation "/sn:subscription-started/sn:target" { deviate not-supported; }`, yet the device sends
   `"ietf-yang-push:datastore"` in the notification. Device issue; the subscription is still learned and its data
   validated. The other 4 `subscription-started` (subs 7, 13, 14, 19) have no schema (note 1).
4. **Data notifications rejected by the receiver (341).** Validated: subs 1, 2, 3, 4, 5, 16, 17, 18 (8 of 16).
   - Subs 6 (164), 11 (1), 12 (164) push-update: `Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to
     map prefix to YANG schema.` (165) and the same for `"iana-if-type:ppp"` (164). The cached module set of content id
     `453f4d25...` has no `iana-if-type`, although the device library implements it.
   - Sub 11 (10 push-change-update): `Node "interface" not found in the "ietf-yang-push" module.`; sub 17 (2 of 4
     push-change-update, the `create` edits): `Node "remote-systems-data" not found in the "ietf-yang-push" module.`
     The yang-patch edit `value` is encoded relative to the edit target, without module prefix.
5. **Messages for 12 of 16 subscriptions.** Subs 1, 2, 3, 4, 5, 16, 17, 18 with their device schema, subs 7, 13, 14, 19
   with schema id 36; nothing is produced for 6, 11, 12, 15 (everything rejected or not decodable). The consumer
   receives all 2,089 produced messages.
6. **Consumer failures (351, all schema id 36).** All 1,734 messages with schema ids 624 / 627 / 628 pass. Of the 355
   messages with schema id 36, the 4 `subscription-started` pass (they contain no device module nodes) and 351 fail:
   248 `No module named "ietf-hardware" in the context.` (sub 13: 2, sub 14: 246), 22 `No module named "ietf-alarms"
   in the context.` (sub 19), 81 `Node "hardware" not found in the "ietf-yang-push" module.` (sub 7: the device
   encodes `"datastore-contents":{"hardware":...}` without the `ietf-hardware:` prefix).
7. **Mockups N/A.** The nine FANO messages of `../../mb-test-cases/` are produced with schema id 627 (NE8000,
   sub 1). All nine fail; the valid one with `No module named "huawei-interface-statistics-mgt" in the context.`
   (a FANO module that is not in the NE8000 library). See `netgauze-messagebroker-consumer/readme.md`.

### Cross-check with NetCalyx 0.4.0

|                                             | NetGauze 0.14 | NetCalyx 0.4.0, local, same inputs | Swisscom `../netcalyx/readme.md` |
|---------------------------------------------|---------------|------------------------------------|----------------------------------|
| Receiver validated / rejected               | 1,734 / 353   | 1,734 / 353                        | not reported                     |
| Receiver forwarded unvalidated / undecodable | 355 / 4       | 355 / 4                            | not reported                     |
| Producer delivered                          | 2,089         | 2,089                              | not reported                     |
| Consumer passed / failed (device messages)  | 1,738 / 351   | 1,738 / 351                        | not reported                     |
| Wall time                                   | 372 s         | 374 s                              | not reported                     |

NetGauze 0.14 and NetCalyx 0.4.0 give identical verdicts and identical counts: the same notifications are validated,
rejected (same error texts), not decodable (message ids 17, 18, 19, 23) and forwarded with schema id 36, the same
schema ids 624 / 627 / 628 are used, and the consumer fails the same 351 messages. NetCalyx produces
`ietf-telemetry-message@2025-10-19`, NetGauze `ietf-telemetry-message@2026-10-25`. The nine mockups fail in both.

Swisscom's table also has both "at least one Notification is validated" rows Failed, with the same subscriptions in
its known-issues list (6, 7, 11, 12, 13, 14, 17, 19). One difference: Swisscom's receiver log shows cached libraries
for subs 7, 13, 14 (`83e6ed2e...`) and 19 (`3f7191b4...`) and rejects them at the receiver; these two content ids are
not in the published cache tarball, so here the same notifications fail at the consumer instead (notes 1, 6). The
Partial verdicts above (Swisscom: Passed) follow from that and from counting "for all subscriptions" strictly.
