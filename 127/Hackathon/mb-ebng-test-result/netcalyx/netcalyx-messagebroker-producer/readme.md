## YANG Message Broker Producer - Message and YANG Schema Production

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 10.215.134.62 netcalyx-udpnotif-yangpush-*.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.215.134.62 netcalyx-udpnotif-yangpush-*.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=216 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=217 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=1 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=2 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=3 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=4 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=202 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=200 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=203 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=201 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=204 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=206 schema_id=235572 content_id="afbee089c8c6f77bd391bc61a251f4eac24a62292f14a40c00b333bb7c91b21b"
subscription_id=208 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=205 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=210 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=211 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=212 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=209 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=214 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=215 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=213 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=300 schema_id=235575 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=207 schema_id=235572 content_id="afbee089c8c6f77bd391bc61a251f4eac24a62292f14a40c00b333bb7c91b21b"
subscription_id=306 schema_id=235575 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=218 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=219 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=220 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=402 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=400 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=401 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=304 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=302 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=303 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=301 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=103 schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"
subscription_id=307 schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"
subscription_id=106 schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=100 schema_id=236414 content_id="3f7191b4c5dba36836715b040e5d537d61cd7003546b3b2db18919ba0daaf3dc"
subscription_id=101 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=102 schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"
subscription_id=104 schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=105 schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=305 schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"
subscription_id=403 schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=404 schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"
subscription_id=405 schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID 
```
netcalyx-udpnotif-yangpush-fmg-left.log:2026-10-09T08:10:53.634797Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=216 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-cgn:cgn/user-tables/user-table } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-fmg-left.log:2026-10-09T08:10:54.712507Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=217 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-cgn:cgn/session-tables/session-table } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-fmg-left.log:2026-10-09T09:35:51.701389Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=1 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-manage:bras-user-manage/access-tables/access-table } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-fmg-left.log:2026-10-09T09:38:14.217342Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=2 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-manage:bras-user-manage/access-tables/access-table/access-user-basic-info } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-fmg-left.log:2026-10-09T10:58:30.385524Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=3 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-manage:bras-user-manage/access-tables/access-table/access-user-edsg-infos/access-user-edsg-info } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-fmg-left.log:2026-10-09T10:58:30.386538Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=4 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-manage:bras-user-manage/online-fail-or-offline-records/online-fail-or-offline-record } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:23:49.076573Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=202 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-dhcpv6-access:bras-dhcpv6-access/dhcpv6-packets-statistics } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.010559Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=200 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-dhcp-access:bras-dhcp-access/dhcp-access-statistics } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.010668Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=203 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-radius:radius/authentication-packet-statistics/authentication-packet-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.010726Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=201 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-dhcp-server:bras-dhcp-server/dhcp-servers/dhcp-server/statistics } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.010792Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=204 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-radius:radius/account-packet-statistics/account-packet-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.010835Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=206 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-statistic:bras-user-statistic/access-user/summary/by-vpn-instances/by-vpn-instance } schema_id=235572 content_id="afbee089c8c6f77bd391bc61a251f4eac24a62292f14a40c00b333bb7c91b21b"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.010948Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=208 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-manage:bras-user-manage/domain-statistics/domain-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011137Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=205 router_content_id="1351147661" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-radius:radius/author-packet-statistics/author-packet-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011225Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=210 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-l2tp-access:bras-l2tp-access/lac-tunnels/lac-tunnel } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011283Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=211 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-l2tp-access:bras-l2tp-access/lac-tunnels/lac-tunnel/redundant } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011320Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=212 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-l2tp-access:bras-l2tp-access/lac-tunnels/lac-tunnel/statistics } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011367Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=209 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-ifm:ifm/interfaces/interface/huawei-bras-basic-access:bas/bas-interface/information } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011398Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=214 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-cgn:cgn/user-table-usages/user-table-usage } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011437Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=215 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-cgn:cgn/session-table-usages/session-table-usage } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011476Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=213 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-l2tp-access:bras-l2tp-access/lac-tunnel-statistics/lac-tunnel-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:06.011539Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=300 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/board-resouce-states/board-resouce-state } schema_id=235575 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:07.208649Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=207 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-user-statistic:bras-user-statistic/access-user/summary/by-user-types/by-user-type } schema_id=235572 content_id="afbee089c8c6f77bd391bc61a251f4eac24a62292f14a40c00b333bb7c91b21b"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:08.360479Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=306 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/board-cpu-core-infos/board-cpu-core-info } schema_id=235575 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:09.478934Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=218 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-ipv4-address-manage:bras-ipv4-address-manage/pool-usage-statistics/pool-usage-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:10.584491Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=219 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-bras-ipv6-address-manage:bras-ipv6-address-manage/ipv6-pools/ipv6-pool/usage } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:11.708163Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=220 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-cpudefend:cpudefend/cpcar/protocol-name-statisticss/protocol-name-statistics } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:53.549558Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=402 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface/statistics } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:56.740140Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=400 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-ifm:ifm/interfaces/interface/common-statistics/in-bit-rate } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:24:57.864832Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=401 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-ifm:ifm/interfaces/interface/common-statistics/out-bit-rate } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T07:48:05.300407Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=304 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/optical-statistic } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T08:00:44.308469Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=302 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/chassiss/chassis/huawei-driver:power-supply-attribute } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T08:00:47.789802Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=303 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/channels/channel } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T08:00:50.052547Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=301 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/physical-entitys/physical-entity } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:18.177654Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=103 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/state } schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:19.465518Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=307 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/state } schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:19.465631Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=106 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/port } schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:30.731370Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=100 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-alarms:alarm-notification } schema_id=236414 content_id="3f7191b4c5dba36836715b040e5d537d61cd7003546b3b2db18919ba0daaf3dc"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:34.664223Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=101 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:34.664337Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=102 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component } schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:34.664391Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=104 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/local-system-data } schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:35.963852Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=105 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/port/remote-systems-data } schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:35.972240Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=305 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/sensor-data } schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:35.973757Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=403 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface } schema_id=235571 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:35.973891Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=404 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component } schema_id=236740 content_id="83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f"

netcalyx-udpnotif-yangpush-left.log:2026-10-09T10:58:35.974041Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.215.134.62 subscription_id=405 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/local-system-data } schema_id=236749 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
```