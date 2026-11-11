## YANG Message Broker Producer - Message and YANG Schema Production

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 10.215.217.123 netcalyx-udpnotif-yangpush-testing-left.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.215.217.123 netcalyx-udpnotif-yangpush-testing-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=1 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=2 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=3 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=4 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=5 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=6 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=11 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=12 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=13 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=14 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=15 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=16 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=17 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=18 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=19 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=20 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=21 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=22 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=23 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=25 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=27 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=81 schema_id=119626 content_id="ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3"
subscription_id=82 schema_id=119633 content_id="369536a436f0d21eabc81ef220e3fca8ac933c667eb26937ef05fb4d499c6fed"
subscription_id=83 schema_id=119638 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"
subscription_id=84 schema_id=119638 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"
subscription_id=85 schema_id=119636 content_id="8a199e95f7dc22c9d48e427d76647fd6dd56e046501b2370d76c03d573eda4c3"
subscription_id=86 schema_id=119630 content_id="9b24ab29c609d764dff3c5d9b7326056a7bcb9e680be565b9f2d15fca86e1b00"
subscription_id=87 schema_id=119641 content_id="da952479f7ed21edea0aa95fec17fdc2eb1622954201c5216bbd12655a44c287"
subscription_id=88 schema_id=119653 content_id="1c5665b1bda78f76baaec1afe3db9eb491af2d770ecc678d9b2fbf3bb4dec5cf"
subscription_id=89 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=90 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=91 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=92 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=93 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=94 schema_id=119657 content_id="7d667a00976c1fe2f927b065214b45bc398f2192bd05572e424a60d12e3ed0f9"
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID 
```
netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:30.376330Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=81 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-nto-misc-oper:memory-summary/nodes/node/summary } schema_id=238730 content_id="ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:35.974171Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=91 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-ptp-oper:ptp/Cisco-IOS-XR-ptp-pd-oper:platform/servo } schema_id=250271 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:35.974315Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=93 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-ptp-oper:ptp/interfaces/interface } schema_id=250271 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:41.222333Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=87 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib/nodes/node/pifib-hw-flow-policer-stats } schema_id=238737 content_id="da952479f7ed21edea0aa95fec17fdc2eb1622954201c5216bbd12655a44c287"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:41.266133Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=85 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-wdsysmon-fd-oper:system-monitoring/cpu-utilization } schema_id=238524 content_id="8a199e95f7dc22c9d48e427d76647fd6dd56e046501b2370d76c03d573eda4c3"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:48.400832Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=86 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-perf-meas-oper:performance-measurement/nodes/node/interfaces/interface-delay/interface-last-probes } schema_id=238528 content_id="9b24ab29c609d764dff3c5d9b7326056a7bcb9e680be565b9f2d15fca86e1b00"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:50.849644Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=89 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-ptp-oper:ptp/advertised-clock } schema_id=250271 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:51.524231Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=83 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-qos-ma-oper:qos/interface-table/interface/input/service-policy-names/service-policy-instance/statistics } schema_id=238785 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:52.638188Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=88 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-platforms-ofa-oper:ofa/stats/nodes/node/Cisco-IOS-XR-8000-platforms-npu-resources-oper:hw-resources-datas/hw-resources-data } schema_id=238722 content_id="1c5665b1bda78f76baaec1afe3db9eb491af2d770ecc678d9b2fbf3bb4dec5cf"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:54.281080Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=82 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-procmem-oper:processes-memory/nodes/node/process-ids/process-id } schema_id=238727 content_id="369536a436f0d21eabc81ef220e3fca8ac933c667eb26937ef05fb4d499c6fed"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T10:59:56.453990Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=92 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-ptp-oper:ptp/advertised-clock } schema_id=250271 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T11:00:16.266505Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=84 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-qos-ma-oper:qos/interface-table/interface/output/service-policy-names/service-policy-instance/statistics } schema_id=238785 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T11:00:23.055315Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=90 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-ptp-oper:ptp/nodes/node/node-interface-foreign-masters } schema_id=250271 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T12:44:35.959818Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=6 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-platform:components/component/openconfig-platform-transceiver:transceiver } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T12:44:35.960136Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=1 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-interfaces:interfaces/interface/state/counters } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T12:44:36.405578Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=4 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-platform:components/component/power-supply/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T12:44:36.405651Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=5 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-platform:components/component/fan/state/openconfig-platform-fan:speed } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T12:44:36.405691Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=3 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-platform:components/component/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T12:44:36.406208Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=2 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-interfaces:interfaces/interface/subinterfaces/subinterface/state/counters } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:55:51.659267Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=94 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /Cisco-IOS-XR-freqsync-oper:frequency-synchronization/nodes/node/selection-point-inputs/selection-point-input } schema_id=119657 content_id="7d667a00976c1fe2f927b065214b45bc398f2192bd05572e424a60d12e3ed0f9"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.804619Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=20 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lacp:lacp/interfaces/interface/state } schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.804689Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=27 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-system:system/alarms } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.804736Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=11 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-interfaces:interfaces/interface/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.805928Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=17 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lacp:lacp/state } schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.805986Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=25 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-network-instance:network-instances/network-instance/protocols/protocol/bgp/neighbors/neighbor/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.806020Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=15 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lldp:lldp/interfaces/interface/neighbors/neighbor/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:41.806096Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=21 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lacp:lacp/interfaces/interface/members/member/state } schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:46.092926Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=18 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lacp:lacp/state } schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:47.754970Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=22 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lacp:lacp/interfaces/interface/members/member/state } schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:49.032021Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=16 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lldp:lldp/interfaces/interface/neighbors/neighbor/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:50.305923Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=23 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-network-instance:network-instances/network-instance/protocols/protocol/isis/interfaces/interface/levels/level/adjacencies } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:56:51.615535Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=12 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-interfaces:interfaces/interface/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:57:10.880456Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=19 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-lacp:lacp/interfaces/interface/state } schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:57:15.233817Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=14 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-interfaces:interfaces/interface/subinterfaces/subinterface/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"

netcalyx-udpnotif-yangpush-testing-left.log:2026-10-26T13:57:17.283228Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.217.123 subscription_id=13 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /openconfig-interfaces:interfaces/interface/subinterfaces/subinterface/state } schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
```