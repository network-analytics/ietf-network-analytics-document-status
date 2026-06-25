## YANG Message Broker Producer - Message and YANG Schema Production

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netgauze
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=1 schema_id=231594 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"
subscription_id=2 schema_id=231594 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"
subscription_id=3 schema_id=231594 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"
subscription_id=4 schema_id=231595 content_id="de952a494c5e5a6b774852d5c1720c5269c94d4fdf9863f3cb3684fdb2ade057"
subscription_id=5 schema_id=231595 content_id="eed2c01635cf828700187bb62284079f6b6fc6c5d95ab7b681a7c7bc952c81a1"
subscription_id=6 schema_id=231595 content_id="3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae"
subscription_id=7 schema_id=231595 content_id="3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae"
subscription_id=8 schema_id=231595 content_id="56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178"
subscription_id=9 schema_id=231595 content_id="56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178"
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID 
```
2026-04-21T01:25:31.074583Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=2 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/cpu-infos/cpu-info } schema_id=231594 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"

2026-04-21T01:25:31.074604Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=3 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/memory-infos/memory-info } schema_id=231594 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"

2026-04-21T01:25:31.087376Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=7 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/optical-statistic } schema_id=231595 content_id="3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae"

2026-04-21T01:25:38.152734Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=1 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/board-resouce-states/board-resouce-state } schema_id=231594 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"

2026-04-21T01:25:38.363661Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=9 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface } schema_id=231595 content_id="56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178"

2026-04-21T01:25:38.763736Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=4 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/chassiss/chassis/huawei-driver:power-supply-attribute } schema_id=231595 content_id="de952a494c5e5a6b774852d5c1720c5269c94d4fdf9863f3cb3684fdb2ade057"

2026-04-21T01:25:39.583486Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=8 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface/statistics } schema_id=231595 content_id="56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178"

2026-04-21T01:25:40.409044Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=6 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/channels/channel } schema_id=231595 content_id="3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae"

2026-04-21T01:25:40.716137Z TRACE netgauze_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer=10.215.131.17:61832 subscription_id=5 router_content_id="1903509911" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/physical-entitys/physical-entity } schema_id=231595 content_id="eed2c01635cf828700187bb62284079f6b6fc6c5d95ab7b681a7c7bc952c81a1"
```