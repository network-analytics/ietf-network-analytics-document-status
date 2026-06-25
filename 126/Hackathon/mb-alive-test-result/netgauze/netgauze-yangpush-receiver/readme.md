## YANG-Push Receiver - Message and YANG Schema Production

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netgauze
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep validated | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=8 schema_id=232713 content_id="8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef"
subscription_id=7 schema_id=232713 content_id="8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a"
subscription_id=1 schema_id=232714 content_id="5c2ff36ed86e12872239b3e2de7589c5a65892810accb4aa52f2ca4ddd3945c2"
subscription_id=9 schema_id=232713 content_id="8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef"
subscription_id=4 schema_id=232713 content_id="291445b819ce7f2a60c90c69edae25a3893c475424e041fc663726bc8d5c7700"
subscription_id=6 schema_id=232713 content_id="8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a"
subscription_id=5 schema_id=232713 content_id="6edae3b4e0ec080847d3b7d6ea38aed212c70747a34ed5b2c0a2269d29509992"
```

### List Cache Directories - All Netconf Collected YANG Schemas per common YANG Schema Tree
```
cd /var/cache/netgauze/yang_schemas
tar -czvf alive-netgauze-receiver-cache-content.tar.gz 8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef 8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a 5c2ff36ed86e12872239b3e2de7589c5a65892810accb4aa52f2ca4ddd3945c2 8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef 291445b819ce7f2a60c90c69edae25a3893c475424e041fc663726bc8d5c7700 8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a 6edae3b4e0ec080847d3b7d6ea38aed212c70747a34ed5b2c0a2269d29509992
```

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID 
```
2026-06-02T10:00:31.039279Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=201 publisher_id=16974839 subscription_id=7 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/optical-statistic } notification_type="YangPushUpdate" cached_content_id="8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a"

2026-06-02T10:00:31.285987Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=51 publisher_id=16974839 subscription_id=1 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-debug:debug/board-resouce-states/board-resouce-state } notification_type="YangPushUpdate" cached_content_id="5c2ff36ed86e12872239b3e2de7589c5a65892810accb4aa52f2ca4ddd3945c2"

2026-06-02T10:00:31.504356Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=51 publisher_id=16974839 subscription_id=9 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface } notification_type="YangPushUpdate" cached_content_id="8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef"

2026-06-02T10:00:31.709904Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=51 publisher_id=16974839 subscription_id=4 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/chassiss/chassis/huawei-driver:power-supply-attribute } notification_type="YangPushUpdate" cached_content_id="291445b819ce7f2a60c90c69edae25a3893c475424e041fc663726bc8d5c7700"

2026-06-02T10:00:32.758296Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=101 publisher_id=16974839 subscription_id=8 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface/statistics } notification_type="YangPushUpdate" cached_content_id="8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef"

2026-06-02T10:00:33.495169Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=51 publisher_id=16974839 subscription_id=6 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/ports/port/huawei-pic:optical-module/channels/channel } notification_type="YangPushUpdate" cached_content_id="8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a"

2026-06-02T10:00:33.889946Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=10.215.131.17:61382 message_id=101 publisher_id=16974839 subscription_id=5 router_content_id="603085078" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /huawei-devm:devm/physical-entitys/physical-entity } notification_type="YangPushUpdate" cached_content_id="6edae3b4e0ec080847d3b7d6ea38aed212c70747a34ed5b2c0a2269d29509992"