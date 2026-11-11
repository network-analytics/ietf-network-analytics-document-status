## YANG Message Broker Producer - Message and YANG Schema Production

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 10.80.32.79 netcalyx-udpnotif-yangpush-*.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.80.32.79 netcalyx-udpnotif-yangpush-*.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=5 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=6 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=1 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=10 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=8 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=15 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=16 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=17 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=18 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=12 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=3 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=2 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=14 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=13 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=4 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=7 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=9 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=11 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=19 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=20 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=21 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=22 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=23 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=24 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=25 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=26 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=27 schema_id=236780 content_id="f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521"
```

### Examples - Message and Validation State for Each YANG-Push Subscription ID 
```
netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:56.494866Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=1 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd']/statistics } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:41.333831Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=2 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:gpon']/statistics } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:40.679014Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=3 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='bbf-xpon-if-type:channel-pair']/statistics } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:46:08.787569Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=4 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='bbf-xpon-if-type:v-ani']/statistics } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:54.864563Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=5 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-qos-traffic-mngt-state:tm-root/queues/queue/statistics } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:54.864674Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=6 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ethernetCsmacd-xcvr']/bbf-hardware-transceivers:transceiver } schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:05.033230Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=7 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ethernetCsmacd-xcvr-link']/bbf-hardware-transceivers:transceiver-link } schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:30.780241Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=8 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:pon-xcvr']/bbf-hardware-transceivers:transceiver } schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:05.092597Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=9 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:pon-xcvr-link']/bbf-hardware-transceivers:transceiver-link } schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:15.726517Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=10 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ont-ani-xcvr']/bbf-hardware-transceivers:transceiver } schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:05.144560Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=11 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ont-ani-xcvr-link']/bbf-hardware-transceivers:transceiver-link } schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:35.399789Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=12 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-xponani:ani } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:46.053465Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=13 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface[type='bbf-xpon-if-type:v-ani']/statistics/bbf-xpon-statistics-management:xpon/phy } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:41.333880Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=14 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface[type='bbf-xpon-if-type:ani']/statistics/bbf-xpon-statistics-management:xpon/phy } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:31.464563Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=15 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/huawei-energy-management-an:energy-consumption } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:31.464631Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=16 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/bbf-hardware-cpu:cpu-processor-data } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:32.128218Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=17 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='iana-hardware:sensor']/sensor-data[value-type='celsius'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:33.124683Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=18 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='iana-hardware:sensor']/sensor-data[value-type='rpm'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:15.768393Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=19 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125424Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=20 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125477Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=21 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:gpon'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125496Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=22 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:gpon'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125515Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=23 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-xponani:ani/bbf-xpon-ani-state:running-info } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125535Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=24 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-xponani:ani/bbf-xpon-ani-state:running-info } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125556Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=25 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='bbf-hardware-types:board'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:18.125574Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=26 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='bbf-hardware-types:board'] } schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:55:25.801921Z TRACE netcalyx_collector::publishers::kafka_yang: Found schemaID for the corresponding contentID peer_ip=10.80.32.79 subscription_id=27 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-alarms:alarm-notification } schema_id=236780 content_id="f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521"
```