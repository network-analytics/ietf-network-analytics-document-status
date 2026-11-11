## YANG Message Broker Producer - Message and YANG Schema Production

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 10.212.242.58 netcalyx-udpnotif-yangpush-*.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.212.242.58 netcalyx-udpnotif-yangpush-*.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=104 schema_id=118828 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"
subscription_id=101 schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=100 schema_id=118695 content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86"
subscription_id=103 schema_id=118707 content_id="8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175"
subscription_id=101 schema_id=118695 content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86"
subscription_id=102 schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=104 schema_id=118697 content_id="add0a8f1059c582885e01df79e854f768477c3515f684c0d1c43fb54b325c3ba"
subscription_id=103 schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=105 schema_id=118707 content_id="8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175"
subscription_id=106 schema_id=118828 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID 
```
netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:06:35.629092Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=104 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /vrouter:state/vrouter-tracker:tracker/icmp-rtt } schema_id=118828 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"

netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:06:37.621337Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=101 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware } schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"

netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:07:39.746360Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=100 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface } schema_id=118695 content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86"

netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:07:39.754560Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=103 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp } schema_id=118707 content_id="8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175"

netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:07:42.662658Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=102 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware } schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"

netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:07:42.663130Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=105 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ieee802-dot1ab-lldp:lldp } schema_id=118707 content_id="8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175"

netcalyx-udpnotif-yangpush-left.log:2026-10-22T07:07:42.663237Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.212.242.58 subscription_id=106 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /vrouter:state/vrouter-tracker:tracker/icmp-rtt } schema_id=118828 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"
```