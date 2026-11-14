## YANG-Push Receiver - Message and YANG Schema Production

Receiver: `netgauze-collector`, NetGauze 0.14, configuration `config-lab.yaml` (listener `127.0.0.1:8123`,
`anydata_strict_validation: true`), replayed publisher `127.0.0.123`. Log: `titan-netgauze-receiver-log.tar.gz`
(`collector.log`, receiver and producer, TRACE level); the commands below run on that file.

### Receiver content
`titan-netgauze-receiver-cache-content.tar.gz`: `<content-id>/{yang-lib.xml,modules/,subscriptions-info.json}`, 11
content ids for the 35 subscriptions (peer `127.0.0.123`, keyed by IP address only):

| Content id | YANG files | Subscriptions |
|------------|-----------:|---------------|
| `0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114` | 51 | 83, 84 |
| `1c5665b1bda78f76baaec1afe3db9eb491af2d770ecc678d9b2fbf3bb4dec5cf` | 61 | 88 |
| `369536a436f0d21eabc81ef220e3fca8ac933c667eb26937ef05fb4d499c6fed` | 52 | 82 |
| `4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08` | 242 | 1-6, 11-16, 23, 25, 27 |
| `7d667a00976c1fe2f927b065214b45bc398f2192bd05572e424a60d12e3ed0f9` | 53 | 94 |
| `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 54 | 89-93 |
| `8a199e95f7dc22c9d48e427d76647fd6dd56e046501b2370d76c03d573eda4c3` | 52 | 85 |
| `9b24ab29c609d764dff3c5d9b7326056a7bcb9e680be565b9f2d15fca86e1b00` | 53 | 86 |
| `c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01` | 244 | 17-22 |
| `ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3` | 52 | 81 |
| `da952479f7ed21edea0aa95fec17fdc2eb1622954201c5216bbd12655a44c287` | 52 | 87 |

The content ids, `yang-lib.xml` and module directories are those of Swisscom's
`../../netcalyx/netcalyx-yangpush-receiver/titan-netcalyx-receiver-cache-content.tar.gz`. The subscription entries were
built from the capture's subscription-started notifications with `tools/build-cache-from-pcap.py`: the device announces
its `datastore-xpath-filter` without a leading `/` and NetGauze 0.14 looks the subscription up with the filter as
announced, while the published cache stores `/Cisco-IOS-XR-nto-misc-oper:...`. NetCalyx 0.4.0 canonicalizes the filter
and uses Swisscom's cache as published. All 35 lookups hit:

```bash
grep -c 'cache hit' collector.log        # 35
INFO netgauze_yang_push::cache::actor: cache hit: yang library reference found in cache peer=127.0.0.123 subscription_id=81 router_content_id="62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: Cisco-IOS-XR-nto-misc-oper:memory-summary/nodes/node/summary } cached_content_id="ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3"
```

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
grep 127.0.0.123 collector.log | grep -c 'Successfully validated'     # 292
grep 127.0.0.123 collector.log | grep -c 'skipping validation step'   # 0
grep 127.0.0.123 collector.log | grep -c 'Failed to validate'         # 167
grep -c 'using default schema ID' collector.log                       # 0
```
459 notifications received, none lost at reassembly or decoding. Validated: 35 subscription-started, 250 push-update,
7 push-change-update. Rejected: 28 push-update, 139 push-change-update.

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 'Successfully validated' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*/\1 \2/' | sort | uniq -c
```
| Subscriptions | Validated: subscription-started / push-update / push-change-update (each) |
|---------------|-----------------------------------------------------------------------------|
| 1, 2, 3, 14 | 1 / 14 / 0 |
| 4, 5, 16, 18, 20, 22, 81, 82, 85-93 | 1 / 7 / 0 |
| 6 | 1 / 21 / 0 |
| 11 | 1 / 6 / 0 |
| 12 | 1 / 42 / 0 |
| 13 | 1 / 2 / 0 |
| 15 | 1 / 1 / 4 |
| 17, 21 | 1 / 1 / 0 |
| 19 | 1 / 1 / 3 |
| 23, 25, 27, 83, 84, 94 | 1 / 0 / 0 |

Schema id and content id per subscription: see `../netgauze-messagebroker-producer/readme.md`.

### Failed Examples - Notifications and Validation State for Each YANG-Push Subscription ID
```bash
grep 'Failed to validate' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*error=(.{0,110}).*/\1 \2 \3/' | sed -E 's/ packet=.*//' | sort | uniq -c | sort -k2 -n
      7 3 YangPushUpdate Invalid union value "openconfig-platform-types:OPTICAL_CHANNEL" - no matching subtype found:
      9 11 YangPushChangeUpdate Node "interface" not found in the "openconfig-interfaces" module.
     64 11 YangPushChangeUpdate Node "state" not found in the "openconfig-interfaces" module.
      4 15 YangPushChangeUpdate Node "state" not found in the "openconfig-lldp" module.
      3 19 YangPushChangeUpdate Node "state" not found in the "openconfig-lacp" module.
     11 21 YangPushChangeUpdate Node "member" not found in the "openconfig-lacp" module.
      4 23 YangPushChangeUpdate Node "adjacencies" not found in the "openconfig-network-instance" module.
     20 25 YangPushChangeUpdate Node "state" not found in the "openconfig-network-instance" module.
     24 27 YangPushChangeUpdate Node "alarms" not found in the "openconfig-system" module.
      7 83 YangPushUpdate Node "policy-timestamp" not found as a child of "statistics" node.
      7 84 YangPushUpdate Node "policy-timestamp" not found as a child of "statistics" node.
      7 94 YangPushUpdate Invalid enumeration value "selection -point".
```
```
WARN netgauze_yang_push::validation: Failed to validate UDP-Notif payload using draft-ietf-netconf-notif-envelope, dropping packet peer=127.0.0.123:37756 message_id=3 publisher_id=0 subscription_id=3 ... target={ datastore: ietf-datastores:operational, datastore-xpath-filter: openconfig-platform:components/component/state } cached_content_id="4cf30b83..." notification_type="YangPushUpdate" error=Invalid union value "openconfig-platform-types:OPTICAL_CHANNEL" - no matching subtype found:
    ly2 identityref: Invalid identityref "openconfig-platform-types:OPTICAL_CHANNEL" value - identity not found in module "openconfig-platform-types".
```
* Subscription 3 (device issue): seven push-updates (message ids 3, 6, 9, 12, 15, 18, 21; 91 UDP-Notif segments each)
  report the component `OpticalChannel0/0/0/0` with `"type":"openconfig-platform-types:OPTICAL_CHANNEL"`. The library's
  `openconfig-platform-types@2024-04-30` has no such identity; it is defined in `openconfig-transport-types@2024-01-16`.
  NetCalyx 0.4.0 does not get to validate these seven: it drops every message of more than 64 segments at reassembly
  (also the 7 push-updates each of subscriptions 85 and 88, which NetGauze validates).
* Subscriptions 11, 15, 19, 21, 23, 25, 27: every rejected push-change-update has a YANG-Patch edit whose `value` is the
  target node itself, e.g. target `/openconfig-lldp:lldp/interfaces/interface[...]/neighbors/neighbor[...]/state` with
  `"value":{"openconfig-lldp:state":{...}}` (126 `replace`, 13 `delete` with a value); the validated ones are `delete`
  edits without a value. NetCalyx 0.4.0 rejects the same 139 with the same errors.
* Subscriptions 83, 84: `policy-timestamp` is in no module of the library. Subscription 94: the device sends
  `"stream-type":"selection -point"`, the enum is `selection-point`. NetCalyx 0.4.0 rejects the same 21.

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID
One validated example per subscription and notification type, as produced to Kafka: `yp-sNNN-subscription-started.json`
(all 35 subscriptions), `yp-sNNN-push-update.json` (all but 23, 25, 27, 83, 84, 94), `yp-sNNN-push-change-update.json`
(15 and 19).
```
TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=127.0.0.123:20487 message_id=0 publisher_id=0 subscription_id=81 ... notification_type="SubscriptionStarted"
```
