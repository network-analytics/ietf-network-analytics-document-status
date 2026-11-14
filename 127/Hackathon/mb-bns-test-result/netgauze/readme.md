## Test Result Summary for YANG Message Broker Consumer Integration Testing

**Test run:** 2026-11-10, single host, loopback. NetGauze 0.14: `netgauze-collector` (UDP-Notif receiver with
`anydata_strict_validation: true`, `TelemetryKafkaYang` producer) and `kafka-yang-consumer -A`. Confluent Platform
7.8.0 (zookeeper, kafka, schema-registry) in docker with yang-schema-registry-plugin 0.0.6-7.4, recreated empty
before the run (`../../docker/docker-compose.kafka.yml`). 6WIND vRouter capture
`daisy-ietf-ipf-zbl1843-r-daisy-58-yp-udpnotif-20261022-1324.pcap` (60 packets, 27 notifications, 6 subscriptions,
360 s) replayed with traffic-reproducer at 20x as `127.0.0.58`, topic `telemetry-message-yang-bns`. Wall time 126 s,
no kernel UDP drops. To reproduce: `../../mb-test-setup/readme.md` (`tools/prepare-lab.sh`, `tools/run-all.sh bns`,
`tools/package-results.sh bns <run-dir>`).

| Component       | Name         | Test Case                                                                          | Passed/Failed/Partial |
|-----------------|--------------|------------------------------------------------------------------------------------|-----------------------|
| Receiver        | NetGauze     | Verify YANG-Push Receiver Content                                                  | Passed                |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher                                    | Passed                |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions Notifications are received             | Passed (see note 1)   |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Partial (see note 2)  |
| Producer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Message is produced       | Passed                |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable        | Passed                |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions Messages are received                  | Passed                |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained          | Passed                |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Passed                |
| Consumer        | NetGauze     | Verify that Mockup Telemetry Messages are validated                                | N/A (see note 4)      |

**Totals:** 27 notifications received (6 subscription-started, 21 push-update): 25 validated, 0 skipped, 2 rejected.
25 messages delivered to Kafka (0 send errors, 0 on the default schema). 188 schema ids registered, no 409/422 from
the registry. Consumer: 25 device messages, 25 PASSED, 0 FAILED. Mockups: 0 PASSED, 9 FAILED.

| Subscription | Target (`datastore-xpath-filter`)                  | Content id | Schema id | Received | Validated | Rejected | Consumer PASSED |
|--------------|----------------------------------------------------|------------|-----------|----------|-----------|----------|-----------------|
| 100          | `/ietf-interfaces:interfaces/interface`            | `2ec7d285` | 62        | 2        | 1         | 1        | 1               |
| 101          | `/ietf-interfaces:interfaces/interface/statistics` | `2ec7d285` | 62        | 7        | 7         | 0        | 7               |
| 102          | `/ietf-hardware:hardware`                          | `6bd32376` | 67        | 2        | 2         | 0        | 2               |
| 103          | `/ietf-hardware:hardware/component/sensor-data`    | `6bd32376` | 67        | 7        | 7         | 0        | 7               |
| 104          | `/ietf-alarms:alarms/alarm-list`                   | `add0a8f1` | 64        | 2        | 1         | 1        | 1               |
| 106          | `/vrouter:state/vrouter-tracker:tracker/icmp-rtt`  | `848fd359` | 188       | 7        | 7         | 0        | 7               |

### Test Result Comments for YANG Message Broker Consumer Integration Testing

1. **Subscription 105 sends nothing (device).** The device configuration
   (`netgauze-yangpush-publisher/daisy-ietf-ipf-zbl1843-r-daisy-58-netconf-yp-subscription-20261022-1222.xml`) has
   seven subscriptions for this receiver, 100-106. 105 (`/lldp:lldp`, on-change) is in
   `configured-subscription-state` `invalid` and has no packet in the capture. The six subscriptions that are in the
   capture are all received. Swisscom reports the same ("doesn't send subscription-started and push-update").
2. **Two push-updates rejected: identityref to a module outside the subscription's YANG library.** Every subscription
   has a validated subscription-started, but the only push-update of 100 and of 104 is rejected, so these two
   subscriptions have no validated push-update:

   | Subscription | Message id | Error text                                                                                             |
   |--------------|------------|--------------------------------------------------------------------------------------------------------|
   | 100          | 6892       | `Invalid identityref "iana-if-type:softwareLoopback" value - unable to map prefix to YANG schema.`     |
   | 104          | 6894       | `Invalid identityref "vrouter-alarm:service-alarm" value - unable to map prefix to YANG schema.`       |

   The YANG library cached for subscription 100 (content id `2ec7d285...`, 34 modules) does not contain
   `iana-if-type`, and the one for 104 (`add0a8f1...`, 35 modules) does not contain `vrouter-alarm`: neither module
   is imported by the subscribed module (`ietf-interfaces`, `ietf-alarms`), they only define identities derived from
   its base identities. The device's full YANG library (`...-netconf-yanglibrary-20261022-1222.xml`) implements both.
   The push-update of 102 carries `iana-hardware:cpu` and validates, because `iana-hardware` is in its library.
   NetCalyx 0.4.0 rejects the same two messages with the same error text.
3. **Push-updates without the subscribed data (device).** All 6 push-updates of 103 carry an empty
   `"datastore-contents": {}`; the 6 push-updates of 101 carry only the interface `name` keys, no `statistics`
   container. They are valid and are counted as validated / PASSED. Swisscom reports 103 as "notification content
   empty".
4. **Mockups: N/A.** The nine `mb-test-cases` messages are FANO (Huawei) telemetry messages; here they are produced
   with schema id 62 (the 6WIND `ietf-interfaces` library). All nine are rejected, the valid one included
   (`No module named "huawei-interface-statistics-mgt" in the context.`), so the test says nothing about this device.

### Cross-check with NetCalyx 0.4.0

|                               | NetGauze 0.14     | NetCalyx 0.4.0, run locally on the same inputs | Swisscom `../netcalyx/readme.md` |
|-------------------------------|-------------------|------------------------------------------------|----------------------------------|
| Receiver validated / rejected | 25 / 2            | 25 / 2                                         | not reported                     |
| Producer delivered            | 25                | 25                                             | not reported                     |
| Consumer passed / failed      | 25 / 0            | 25 / 0                                         | not reported (log: 17 / 7)       |
| Mockups passed / failed       | 0 / 9             | 0 / 9                                          | not reported                     |
| Schema ids (100+101, 102+103, 104, 106) | 62, 67, 64, 188 | 66, 65, 68, 189                        | 118694-118828 (live registry)    |
| Wall time                     | 126 s             | 127 s                                          | not reported                     |

NetGauze 0.14 and NetCalyx 0.4.0 give identical verdicts and identical counts on the same inputs: the same 25
notifications validated, the same two rejected (message ids 6892 and 6894, same error text), 25 delivered, 25 PASSED.
The only differences are the schema ids and the produced envelope: `ietf-telemetry-message@2026-10-25` (NetGauze)
against `@2025-10-19` (NetCalyx), which changes the error text of six of the nine mockups.

Swisscom's readme has no counts. It marks "Notifications are received" Failed (subscription 105, note 1) and both
"at least one Notification is validated" rows Failed. Its receiver issues are the two identityref rejections of note 2
(listed as 100 and 102; in its logs 102 is the `/ietf-alarms:alarms/alarm-list` subscription) and the empty content of
103 (note 3). Its consumer issue is subscription 106 (NetCalyx issue 71): the published log
`../netcalyx/netcalyx-messagebroker-consumer/6wind-bns-netgauze-mb-consumer-log.txt` has 17 PASSED and 7 FAILED, all 7
on schema id 118828 (content id `848fd359...`, the vrouter library) with
`failed to get/create YANG context: Unknown error: 3`. Here the 7 messages of that library (subscription 106, schema
id 188) pass, with NetGauze 0.14 and with NetCalyx 0.4.0 alike. Swisscom's logs are from a live session with other
subscription ids, so the remaining 17 against 18 cannot be matched message by message.
