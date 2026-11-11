## YANG-Push Receiver - Message and YANG Schema Production

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 10.80.32.79 netcalyx-udpnotif-yangpush-*.log | grep YangPushUpdate | grep validate | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
grep 10.80.32.79 netcalyx-udpnotif-yangpush-*.log | grep YangPushChangeUpdate | grep validate | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
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

### List Cache Directories - All Netconf Collected YANG Schemas per common YANG Schema Tree
```
cd /var/cache/netcalyx/yang_schemas
tar -czvf fano-netcalyx-receiver-cache-content.tar.gz 38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482 53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061 f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521
```

### Successful Examples - Notifications and Validation State for Each YANG-Push Subscription ID 
```
netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:56.494224Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=35942 publisher_id=3021116866 subscription_id=1 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd']/statistics } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:41.328982Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15675 publisher_id=4227923968 subscription_id=2 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:gpon']/statistics } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:40.678401Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15674 publisher_id=4227923968 subscription_id=3 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='bbf-xpon-if-type:channel-pair']/statistics } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:46:08.787466Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15678 publisher_id=4227923968 subscription_id=4 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='bbf-xpon-if-type:v-ani']/statistics } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:42.705175Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=4624 publisher_id=3021116856 subscription_id=5 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-qos-traffic-mngt-state:tm-root/queues/queue/statistics } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:42.011829Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=4623 publisher_id=3021116856 subscription_id=6 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ethernetCsmacd-xcvr']/bbf-hardware-transceivers:transceiver } notification_type="YangPushUpdate" cached_content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:30.780129Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15662 publisher_id=4227923968 subscription_id=8 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:pon-xcvr']/bbf-hardware-transceivers:transceiver } notification_type="YangPushUpdate" cached_content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:15.726107Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15657 publisher_id=4227923968 subscription_id=10 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ont-ani-xcvr']/bbf-hardware-transceivers:transceiver } notification_type="YangPushUpdate" cached_content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:35.399647Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15664 publisher_id=4227923968 subscription_id=12 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-xponani:ani } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:46.053264Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15677 publisher_id=4227923968 subscription_id=13 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface[type='bbf-xpon-if-type:v-ani']/statistics/bbf-xpon-statistics-management:xpon/phy } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:41.329101Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=15097 publisher_id=4227923969 subscription_id=14 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface[type='bbf-xpon-if-type:ani']/statistics/bbf-xpon-statistics-management:xpon/phy } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:31.463840Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=1715 publisher_id=3021116857 subscription_id=15 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/huawei-energy-management-an:energy-consumption } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:31.463958Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=1716 publisher_id=3021116857 subscription_id=16 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/bbf-hardware-cpu:cpu-processor-data } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:32.127578Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=1717 publisher_id=3021116857 subscription_id=17 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='iana-hardware:sensor']/sensor-data[value-type='celsius'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:33.122984Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=1718 publisher_id=3021116857 subscription_id=18 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='iana-hardware:sensor']/sensor-data[value-type='rpm'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:55:25.798750Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=26 publisher_id=3021116857 subscription_id=19 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T16:00:31.308106Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=94 publisher_id=3021116857 subscription_id=20 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:55:25.801048Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=28 publisher_id=3021116857 subscription_id=21 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:gpon'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T16:00:31.312522Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=96 publisher_id=3021116857 subscription_id=22 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface[type='iana-if-type:gpon'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:55:25.801295Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=29 publisher_id=3021116857 subscription_id=23 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-xponani:ani/bbf-xpon-ani-state:running-info } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T16:00:31.316336Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=97 publisher_id=3021116857 subscription_id=24 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces-state/interface/bbf-xponani:ani/bbf-xpon-ani-state:running-info } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:55:26.157903Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=31 publisher_id=3021116857 subscription_id=25 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='bbf-hardware-types:board'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

netcalyx-udpnotif-yangpush-right.log:2026-10-20T16:00:31.386921Z TRACE netcalyx_yang_push::validation: Successfully validated YANG-Push message peer=10.80.32.79:10100 message_id=98 publisher_id=3021116857 subscription_id=26 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[class='bbf-hardware-types:board'] } notification_type="YangPushUpdate" cached_content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"

```

### Failed Examples - Notifications and Validation State for Each YANG-Push Subscription ID 
```
netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:42:42.705924Z  WARN netcalyx_yang_push::validation: Failed to validate UDP-Notif payload, dropping packet peer=10.80.32.79:10100 message_id=4627 publisher_id=3021116856 subscription_id=7 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ethernetCsmacd-xcvr-link']/bbf-hardware-transceivers:transceiver-link } cached_content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061" notification_type="YangPushUpdate" error=Invalid union value "-5000" - no matching subtype found:

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:30.451556Z  WARN netcalyx_yang_push::validation: Failed to validate UDP-Notif payload, dropping packet peer=10.80.32.79:10100 message_id=15658 publisher_id=4227923968 subscription_id=9 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:pon-xcvr-link']/bbf-hardware-transceivers:transceiver-link } cached_content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061" notification_type="YangPushUpdate" error=Invalid union value "349" - no matching subtype found:


netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:45:15.391279Z  WARN netcalyx_yang_push::validation: Failed to validate UDP-Notif payload, dropping packet peer=10.80.32.79:10100 message_id=15656 publisher_id=4227923968 subscription_id=11 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component[huawei-hardware:sub-class='huawei-hardware-types:ont-ani-xcvr-link']/bbf-hardware-transceivers:transceiver-link } cached_content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061" notification_type="YangPushUpdate" error=Invalid union value "1013" - no matching subtype found:

netcalyx-udpnotif-yangpush-right.log:2026-10-20T13:48:04.964411Z  WARN netcalyx_yang_push::validation: Failed to validate UDP-Notif payload, dropping packet peer=10.80.32.79:10100 message_id=1719 publisher_id=3021116857 subscription_id=27 router_content_id="22934" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-alarms:alarm-notification } cached_content_id="f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521" notification_type="YangPushChangeUpdate" error=No module named "huawei-alarm-type-an" in the context. packet="{\"ietf-yp-notification:envelope\":{\"event-time\":\"2026-10-20T13:48:04.570Z\",\"hostname\":\"ipd-zbl1536-s-ah-79\",\"sequence-number\":149,\"contents\":{\"ietf-yang-push:push-change-update\":{\"id\":27,\"ietf-yp-observation:timestamp\":\"2026-10-20T13:48:04.440Z\",\"ietf-yp-observation:point-in-time\":\"state-changed\",\"ietf-distributed-notif:message-publisher-id\":3021116857,\"datastore-changes\":{\"yang-patch\":{\"patch-id\":\"160\",\"edit\":[{\"edit-id\":\"0\",\"operation\":\"merge\",\"target\":\"/ietf-alarms:alarm-notification\",\"value\":{\"ietf-alarms:alarm-notification\":{\"resource\":\"system.SA-PF01-daisy1.138.187.58.122.Log on\",\"huawei-alarm-type-an:alarm-type-id\":\"hw-alarm-type-an:managing-user-login-logout\",\"alarm-type-qualifier\":\"\",\"time\":\"2026-10-20T13:48:04Z\",\"perceived-severity\":\"minor\",\"alarm-text\":\"The managing user of the equipment logout or logon\",\"an-alarm-management:notification-serial-id\":111873,\"an-alarm-management:alarm-name\":\"The managing user of the equipment logout or logon\",\"ietf-alarms-x733:event-type\":\"environmental-alarm\",\"ietf-alarms-x733:probable-cause\":234881026,\"ietf-alarms-x733:probable-cause-string\":\"The maintenance user logs in to the system, logs out of the system, or fails to log in to the system\",\"ietf-alarms-x733:proposed-repair-actions\":[\"No need to deal with it\"],\"ietf-alarms-x733:additional-information\":[{\"identifier\":\"Alarm-id\",\"significant\":true,\"information\":\"239312897\"},{\"identifier\":\"Alarm-class\",\"significant\":true,\"information\":\"security\"},{\"identifier\":\"Alarm-sn\",\"significant\":true,\"information\":\"107598\"},{\"identifier\":\"Alarm-format\",\"significant\":true,\"information\":\"system.username.clientip.loginstatus\"},{\"identifier\":\"User name\",\"significant\":true,\"information\":\"SA-PF01-daisy1\"},{\"identifier\":\"Log mode\",\"significant\":true,\"information\":\"SSH\"},{\"identifier\":\"IP\",\"significant\":true,\"information\":\"138.187.58.122\"},{\"identifier\":\"State\",\"significant\":true,\"information\":\"Log on\"}]}}}]}}}}}}"

```