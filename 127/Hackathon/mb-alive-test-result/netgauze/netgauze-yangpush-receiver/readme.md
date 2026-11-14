## YANG-Push Receiver - Message and YANG Schema Production

NetGauze 0.14 collector, configuration `config-lab.yaml` (UDP-Notif listener `[::1]:8123`,
`anydata_strict_validation: true`). Log: `alive-netgauze-receiver-log.tar.gz` (`collector.log`, receiver and producer).
The publisher `2001:db8:48::1` is replayed as `::1`.

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
tar -xzf alive-netgauze-receiver-log.tar.gz
grep -c 'Successfully validated' collector.log               # 1734  validated
grep -c 'skipping validation step' collector.log             # 355   no schema, forwarded without validation
grep -c 'Failed to validate' collector.log                   # 353   rejected
grep -c 'Failed to decode UDP-Notif payload' collector.log   # 4     not valid JSON
grep 'Successfully validated' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*/\1 \2/' | sort -n | uniq -c
```

```
     82 1 YangPushUpdate
     82 2 YangPushUpdate
    324 3 YangPushUpdate
     81 4 YangPushUpdate
    999 5 YangPushUpdate
     82 16 YangPushUpdate
      2 17 YangPushChangeUpdate
     82 18 YangPushUpdate
```

2,446 messages received = 1,734 + 355 + 353 + 4. Per subscription (the same three `sed` forms on
`Successfully validated`, `skipping validation step`, `Failed to validate`; the subscription of the four undecodable
messages is read from the capture):

| Sub | datastore-xpath-filter                                                    | Cached content id | subscription-started | push-update                    | push-change-update      |
|-----|---------------------------------------------------------------------------|-------------------|----------------------|--------------------------------|-------------------------|
| 1   | `/huawei-debug:debug/board-resouce-states/board-resouce-state`            | `ba7855ef...`     | 1 rejected           | 82 validated                   |                         |
| 2   | `/huawei-devm:devm/chassiss/chassis/huawei-driver:power-supply-attribute` | `453f4d25...`     | 1 rejected           | 82 validated                   |                         |
| 3   | `/huawei-devm:devm/physical-entitys/physical-entity`                      | `453f4d25...`     | 1 rejected           | 324 validated                  |                         |
| 4   | `/huawei-devm:devm/ports/port/huawei-pic:optical-module/channels/channel` | `453f4d25...`     | 1 rejected           | 81 validated                   |                         |
| 5   | `/huawei-devm:devm/ports/port/huawei-pic:optical-module/optical-statistic` | `453f4d25...`    | 1 rejected           | 999 validated                  |                         |
| 6   | `/ietf-interfaces:interfaces/interface`                                   | `453f4d25...`     | 1 rejected           | 164 rejected                   |                         |
| 7   | `/ietf-hardware:hardware/component/sensor-data`                           | none              | 1 unvalidated        | 81 unvalidated                 |                         |
| 11  | `/ietf-interfaces:interfaces/interface`                                   | `453f4d25...`     | 1 rejected           | 1 rejected                     | 10 rejected             |
| 12  | `/ietf-interfaces:interfaces/interface`                                   | `453f4d25...`     | 1 rejected           | 164 rejected                   |                         |
| 13  | `/ietf-hardware:hardware/component`                                       | none              | 1 unvalidated        | 2 unvalidated, 1 not decodable |                         |
| 14  | `/ietf-hardware:hardware/component`                                       | none              | 1 unvalidated        | 246 unvalidated                |                         |
| 15  | `/ieee802-dot1ab-lldp:lldp/local-system-data`                             | `8c492dc8...`     | 1 rejected           | 1 not decodable                |                         |
| 16  | `/ieee802-dot1ab-lldp:lldp/local-system-data`                             | `8c492dc8...`     | 1 rejected           | 82 validated                   |                         |
| 17  | `/ieee802-dot1ab-lldp:lldp/port/remote-systems-data`                      | `8c492dc8...`     | 1 rejected           | 2 not decodable                | 2 validated, 2 rejected |
| 18  | `/ieee802-dot1ab-lldp:lldp/port/remote-systems-data`                      | `8c492dc8...`     | 1 rejected           | 82 validated                   |                         |
| 19  | `/ietf-alarms:alarm-notification`                                         | none              | 1 unvalidated        |                                | 22 unvalidated          |

At least one notification validated: subscriptions 1, 2, 3, 4, 5, 16, 17, 18 (8 of 16).

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep ::1 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
```

```
subscription_id=1 schema_id=627 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=2 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=3 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=4 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=5 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=16 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=17 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=18 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
```

### List Cache Directories - All Netconf Collected YANG Schemas per common YANG Schema Tree
`alive-netgauze-receiver-cache-content.tar.gz` is the receiver cache Swisscom published
(`../../netcalyx/netcalyx-yangpush-receiver/alive-netcalyx-receiver-cache-content.tar.gz`) in the NetGauze
`subscriptions-info.json` layout with the peer remapped to `::1` (`tools/convert-netcalyx-cache.py`). Each directory
holds `yang-lib.xml`, `subscriptions-info.json` and `modules/`.

```bash
tar -tzf alive-netgauze-receiver-cache-content.tar.gz | grep '/modules/.' | cut -d/ -f2 | sort | uniq -c
```

```
    579 453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb
    587 8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd
    581 ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285
```

| Content id    | Module files | Subscriptions        |
|---------------|--------------|----------------------|
| `453f4d25...` | 579          | 2, 3, 4, 5, 6, 11, 12 |
| `8c492dc8...` | 587          | 15, 16, 17, 18       |
| `ba7855ef...` | 581          | 1                    |

Subscriptions 7, 13, 14 and 19 are not in the cache: 12 `cache hit: yang library reference found in cache`, 4
`cache miss: starting fetch from device`. The lab has no NETCONF server (`error connecting to device over SSH
host=[::1]:12345 ... Connection refused`), so these subscriptions have no schema and their 355 notifications are
forwarded without validation.

### Successful Examples - Notifications and Validation State for Each YANG-Push Subscription ID
First validated notification per subscription (line shortened to its key fields):
```bash
grep 'Successfully validated' collector.log | awk -F'subscription_id=' '!seen[$2+0]++' | sed -E 's/^([^ ]+) .*(message_id=[0-9]+).*(subscription_id=[0-9]+).*(notification_type="[A-Za-z]+") (cached_content_id="[0-9a-f]{8}).*/\1 \2 \3 \4 \5..."/' | sort -t '=' -k3 -n
```

```
2026-11-10T10:15:57.618090Z message_id=34 subscription_id=1 notification_type="YangPushUpdate" cached_content_id="ba7855ef..."
2026-11-10T10:15:57.791171Z message_id=54 subscription_id=2 notification_type="YangPushUpdate" cached_content_id="453f4d25..."
2026-11-10T10:15:58.069418Z message_id=65 subscription_id=3 notification_type="YangPushUpdate" cached_content_id="453f4d25..."
2026-11-10T10:15:58.059478Z message_id=64 subscription_id=4 notification_type="YangPushUpdate" cached_content_id="453f4d25..."
2026-11-10T10:15:57.621869Z message_id=36 subscription_id=5 notification_type="YangPushUpdate" cached_content_id="453f4d25..."
2026-11-10T10:15:58.011800Z message_id=60 subscription_id=16 notification_type="YangPushUpdate" cached_content_id="8c492dc8..."
2026-11-10T10:15:57.115133Z message_id=24 subscription_id=17 notification_type="YangPushChangeUpdate" cached_content_id="8c492dc8..."
2026-11-10T10:15:58.032686Z message_id=61 subscription_id=18 notification_type="YangPushUpdate" cached_content_id="8c492dc8..."
```

Notification examples, extracted from the messages consumed from Kafka: `yp-s001-push-update.json`,
`yp-s002-push-update.json`, `yp-s003-push-update.json`, `yp-s004-push-update.json`, `yp-s005-push-update.json`,
`yp-s016-push-update.json`, `yp-s017-push-change-update.json`, `yp-s018-push-update.json`; forwarded without
validation: `yp-s007-*.json`, `yp-s013-*.json`, `yp-s014-*.json`, `yp-s019-*.json` (`subscription-started` and one
data notification each). Subscriptions 6, 11, 12 and 15 have no example: nothing of them reaches Kafka.

### Failed Examples - Notifications and Validation State for Each YANG-Push Subscription ID
```bash
grep 'Failed to validate' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*error=(.*) packet=.*/\1 \2 \3/' | sort | uniq -c | sort -k2 -n
grep 'Failed to decode UDP-Notif payload' collector.log | sed -E 's/.*(message_id=[0-9]+).*(error=.*)/\1 \2/'
```

```
      1 1 SubscriptionStarted Node "datastore" not found as a child of "subscription-started" node.
      (the same single line for subscriptions 2, 3, 4, 5, 6, 11, 12, 15, 16, 17, 18)
     82 6 YangPushUpdate Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to map prefix to YANG schema.
     82 6 YangPushUpdate Invalid identityref "iana-if-type:ppp" value - unable to map prefix to YANG schema.
      1 11 YangPushUpdate Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to map prefix to YANG schema.
     10 11 YangPushChangeUpdate Node "interface" not found in the "ietf-yang-push" module.
     82 12 YangPushUpdate Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to map prefix to YANG schema.
     82 12 YangPushUpdate Invalid identityref "iana-if-type:ppp" value - unable to map prefix to YANG schema.
      2 17 YangPushChangeUpdate Node "remote-systems-data" not found in the "ietf-yang-push" module.

message_id=17 error=JSON error: control character (\u0000-\u001F) found while parsing a string at line 1 column 587
message_id=18 error=JSON error: control character (\u0000-\u001F) found while parsing a string at line 2 column 0
message_id=19 error=JSON error: control character (\u0000-\u001F) found while parsing a string at line 1 column 1311
message_id=23 error=JSON error: invalid escape at line 1 column 7498
```

| Subscriptions                | Count | Cause                                                                                              |
|------------------------------|-------|----------------------------------------------------------------------------------------------------|
| 1-6, 11, 12, 15-18 (started) | 12    | Device: `huawei-ietf-subscribed-notifications-deviations-NE8000-F1A@2025-02-24` has `deviation "/sn:subscription-started/sn:target" { deviate not-supported; }`, but the device sends `"ietf-yang-push:datastore"`. The subscription is still learned and its data validated. |
| 6, 11, 12 (push-update)      | 329   | The cached module set `453f4d25...` has no `iana-if-type` (the device library `../netgauze-yangpush-publisher/ipf-zbl1327-r-daisy-48-nc-yanglibrary-20260911-0943.xml` implements it). |
| 11, 17 (push-change-update)  | 12    | The yang-patch edit `value` is encoded relative to the edit target without module prefix (`"value":{"interface":[...]}`, `"value":{"remote-systems-data":[...]}`). The two `delete` edits of subscription 17 carry no value and validate. |
| 15, 17, 17, 13 (push-update) | 4     | Device sends invalid JSON: raw CR/LF inside the LLDP `system-description` string (messages 17, 18, 19) and `\0` escapes in the ietf-hardware `uri` leaf-list (`"urn:clei:\0"`, message 23). |

NetCalyx 0.4.0, run locally on the same capture and cache, rejects, skips and fails to decode exactly the same
notifications with the same error texts.
