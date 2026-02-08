## YANG-Push Receiver - YANG Schema Retrieval

https://datatracker.ietf.org/doc/html/draft-ietf-nmop-yang-message-broker-integration-10#section-4.3 describes that once new YANG-Push subscription is established all subscription related YANG schemas are obtained from YANG-Push publisher and cached locally. The dependencies include: imports, augments, deviations and features being used for each YANG module.


### Netgauze Implementation

In /var/cache/netgauze/yang-schemas/ for each unique YANG schema tree a new directory is being automatically created and named after a locally generated cache contend-id. Within the subdirectory modules all netconf <get-schema> collected YANG modules are stored and with yang-lib.xml a YANG library context is being generated automatically. The subscription-info.json describes the relation between YANG-Push publisher node, YANG-Push subscription id, YANG library content-id of the YANG-Push publisher and the receiver and the YANG-Push subscription started metadata describing which xpath in which datastore and list of directly imported YANG modules. See below an example for YANG library cache contend-id 06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827.

```
[root@dev-col-left01 ~]# cd  /var/cache/netgauze/yang_schemas/06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827
[root@dev-col-left01 06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827]# ll
total 160
drwxr-xr-x 2 root root  20480 Jan 22 14:43 modules
-rw-r--r-- 1 root root   3588 Jan 30 15:56 subscriptions-info.json
-rw-r--r-- 1 root root 133250 Jan 22 14:43 yang-lib.xml
[root@dev-col-left01 06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827]# cat subscriptions-info.json
[
  {
    "peer": "10.190.64.79:10100",
    "id": 1,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.190.64.79:10100",
    "id": 2,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:gpon']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.80.48.42:10100",
    "id": 1,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.80.48.42:10100",
    "id": 2,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:gpon']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.190.64.79:10100",
    "id": 100,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.190.64.79:10100",
    "id": 100,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:gpon']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.190.64.78:10100",
    "id": 1,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:ethernetCsmacd']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  },
  {
    "peer": "10.190.64.78:10100",
    "id": 2,
    "content_id": "22851",
    "target": {
      "ietf-yang-push:datastore": "ietf-datastores:operational",
      "ietf-yang-push:datastore-xpath-filter": "/ietf-interfaces:interfaces/interface[type='iana-if-type:gpon']/statistics"
    },
    "models": [
      "iana-if-type",
      "huawei-interface-statistics-mgt",
      "ietf-interfaces",
      "ietf-subscribed-notifications"
    ]
  }
]
```