## YANG Message Broker Producer - Message and YANG Schema Production

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 2001:db8:48::1 netcalyx-udpnotif-yangpush-right.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 2001:db8:48::1 netcalyx-udpnotif-yangpush-right.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=5 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=1 schema_id=1240 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=2 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=16 schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=18 schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=4 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=3 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID 
```
2026-09-18T01:07:31.057474Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=5 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/optical-statistic } schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

2026-09-18T01:07:31.609956Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=1 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/board-resouce-states/board-resouce-state } schema_id=1240 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"

2026-09-18T01:07:34.358697Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=2 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/chassiss/chassis/huawei-driver:power-supply-attribute } schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

2026-09-18T01:07:34.781124Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=16 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/local-system-data } schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

2026-09-18T01:07:35.419000Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=18 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/port/remote-systems-data } schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

2026-09-18T01:07:39.742209Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=4 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/channels/channel } schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

2026-09-18T01:07:39.884971Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=3 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/physical-entitys/physical-entity } schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"

2026-09-18T06:44:44.144507Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=2001:db8:48::1 subscription_id=17 router_content_id="2300156437" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp/port/remote-systems-data } schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
```