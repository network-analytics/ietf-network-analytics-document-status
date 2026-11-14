## YANG-Push Receiver - Message and YANG Schema Production

Receiver: `netgauze-collector` of NetGauze 0.14 with `config-lab.yaml` (this directory): UDP-Notif listener
`127.0.0.1:8123`, `anydata_strict_validation: true`, logging `netgauze_collector=trace,netgauze_yang_push=trace,info`.
Log: `bns-netgauze-receiver-log.tar.gz` (`collector.log`, receiver and producer in one process).

### Receiver content
`bns-netgauze-receiver-cache-content.tar.gz`: one directory per content id (canonical digest of the YANG library)
with `yang-lib.xml`, `modules/` and `subscriptions-info.json`. The device is not reachable from the lab, so every
subscription is answered from this cache: `loaded YANG Library references cache total_entries=5`, 6 cache hits,
0 misses, no NETCONF `<get-schema>`.

| Content id                                                         | Module files | Target of the cached subscriptions                 | Subscriptions in this run |
|--------------------------------------------------------------------|--------------|----------------------------------------------------|---------------------------|
| `2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86` | 34           | `/ietf-interfaces:interfaces/interface[/statistics]` | 100, 101                |
| `6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8` | 36           | `/ietf-hardware:hardware[/component/sensor-data]`  | 102, 103                  |
| `add0a8f1059c582885e01df79e854f768477c3515f684c0d1c43fb54b325c3ba` | 35           | `/ietf-alarms:alarms/alarm-list`                   | 104                       |
| `848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c` | 155          | `/vrouter:state/vrouter-tracker:tracker/icmp-rtt`  | 106                       |
| `8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175` | 45           | `/ieee802-dot1ab-lldp:lldp`                        | none (105 sends nothing)  |

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
grep -c "Successfully validated" collector.log        # 25
grep -c "skipping validation step" collector.log      # 0
grep -c "Failed to validate" collector.log            # 2
grep "Decoded UDP-Notif payload" collector.log | sed -E 's/.*message_id=([0-9]+).*/\1/' | sort -u | wc -l   # 27
grep 127.0.0.58 collector.log | grep YangPushUpdate | grep validated | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```
The last command returns one validated push-update for 102 (message id 6893), 101 (6899), 106 (6900) and 103 (6901);
100 and 104 have none. 9 packets arrived while the schema lookup or the libyang context of their subscription was
pending; they were buffered and validated afterwards (no default-schema message, nothing skipped).

### Failed Examples - Notifications Rejected by the YANG Validation
```
2026-11-10T12:16:45.031163Z  WARN netgauze_yang_push::validation: Failed to validate UDP-Notif payload using draft-ietf-netconf-notif-envelope, dropping packet peer=127.0.0.58:43972 message_id=6892 publisher_id=0 subscription_id=100 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-interfaces:interfaces/interface } cached_content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86" notification_type="YangPushUpdate" error=Invalid identityref "iana-if-type:softwareLoopback" value - unable to map prefix to YANG schema.
2026-11-10T12:16:45.034379Z  WARN netgauze_yang_push::validation: Failed to validate UDP-Notif payload using draft-ietf-netconf-notif-envelope, dropping packet peer=127.0.0.58:43972 message_id=6894 publisher_id=0 subscription_id=104 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-alarms:alarms/alarm-list } cached_content_id="add0a8f1059c582885e01df79e854f768477c3515f684c0d1c43fb54b325c3ba" notification_type="YangPushUpdate" error=Invalid identityref "vrouter-alarm:service-alarm" value - unable to map prefix to YANG schema.
```
Both are the only push-update of an on-change subscription. `iana-if-type` is not among the 34 modules of
`2ec7d285...` and `vrouter-alarm` is not among the 35 modules of `add0a8f1...` (`vrouter-alarm` is only in
`848fd359...`): `ietf-interfaces` and `ietf-alarms` do not import them, the two modules define identities derived
from `if:interface-type` and `al:alarm-type-id`. The device implements both (see
`../netgauze-yangpush-publisher/daisy-ietf-ipf-zbl1843-r-daisy-58-netconf-yanglibrary-20261022-1222.xml`). The
push-update of 102 (`"class": "iana-hardware:cpu"`) validates because `iana-hardware` is in `6bd32376...`.
NetCalyx 0.4.0 rejects the same two messages with the same error text.

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep "Successfully validated" collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*/\1 \2/' | sort | uniq -c
```
| Subscription | Content id    | subscription-started validated | push-update validated | push-update rejected |
|--------------|---------------|--------------------------------|-----------------------|----------------------|
| 100          | `2ec7d285...` | 1                              | 0                     | 1                    |
| 101          | `2ec7d285...` | 1                              | 6                     | 0                    |
| 102          | `6bd32376...` | 1                              | 1                     | 0                    |
| 103          | `6bd32376...` | 1                              | 6                     | 0                    |
| 104          | `add0a8f1...` | 1                              | 0                     | 1                    |
| 106          | `848fd359...` | 1                              | 6                     | 0                    |
| total        |               | 6                              | 19                    | 2                    |

Device content: the 6 push-updates of 103 have `"datastore-contents": {}`; the 6 push-updates of 101 list interface
names only (`[{"name":"Loopback-A9-main"}]`), without `statistics`. Both are valid.

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID
One notification per subscription and type as received (JSON): `yp-s100-subscription-started.json`,
`yp-s101-subscription-started.json`, `yp-s101-push-update.json`, `yp-s102-subscription-started.json`,
`yp-s102-push-update.json`, `yp-s103-subscription-started.json`, `yp-s103-push-update.json`,
`yp-s104-subscription-started.json`, `yp-s106-subscription-started.json`, `yp-s106-push-update.json`.
```
2026-11-10T12:16:44.988298Z  INFO netgauze_yang_push::cache::actor: cache hit: yang library reference found in cache peer=127.0.0.58 subscription_id=103 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/sensor-data } cached_content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
2026-11-10T12:16:45.051261Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=127.0.0.58:43972 message_id=6889 publisher_id=0 subscription_id=103 router_content_id="964707179" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-hardware:hardware/component/sensor-data } notification_type="SubscriptionStarted" cached_content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
```
