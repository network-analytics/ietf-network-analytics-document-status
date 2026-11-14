## YANG-Push Receiver - Message and YANG Schema Production

Receiver: `netgauze-collector`, NetGauze 0.14, config `config-lab.yaml` (this directory): UDP-Notif listener
`127.0.0.1:8123`, `anydata_strict_validation: true`, replayed peer `127.0.0.62`. Log: `collector.log` in
`ebng-netgauze-receiver-log.tar.gz` (`netgauze_collector=trace,netgauze_yang_push=trace,info`).

### Receiver content
Swisscom published no eBNG receiver cache: `ebng-netcalyx-receiver-cache-content.tar.gz` in
`../../netcalyx/netcalyx-yangpush-receiver/` is byte-identical to the ALIVE one. The cache was rebuilt with
`tools/build-cache-from-pcap.py`: subscriptions from the 44 `subscription-started` of the capture, modules from the
ALIVE receiver cache and the eBNG consumer cache.

```bash
tar -tzf ebng-netgauze-receiver-cache-content.tar.gz    # <content-id>/{yang-lib.xml,modules/,subscriptions-info.json}
453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb  579 modules  subs 1-4, 101, 200-205, 208-220, 301-304, 400-403
8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd  587 modules  subs 104, 105, 106, 405
afbee089c8c6f77bd391bc61a251f4eac24a62292f14a40c00b333bb7c91b21b  581 modules  subs 206, 207
ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285  581 modules  subs 300, 306
3f7191b4c5dba36836715b040e5d537d61cd7003546b3b2db18919ba0daaf3dc  581 modules  sub 100
83e6ed2ea8275413d17fd7bda50ed4e67d1ffad20154ef621183cc362791479f  582 modules  subs 102, 305, 404

grep -c 'cache hit' collector.log                                                          # 44 (0 'cache miss')
grep -c 'YANG context for this content-id is being built, waiting for it' collector.log    # 38 = 44 subscriptions - 6
grep -c 'Cached UDP-Notif packet' collector.log                                            # 235
```
The six libraries differ only by the modules of the subscribed subtree (`ietf-alarms`, `ietf-hardware`, LLDP and
routing, `huawei-bras-user-statistic`, `huawei-debug`, each with its NE8000 deviation module). One libyang context is
built per content id and shared by its subscriptions: all 44 subscriptions are resolved 1.4 s after the first
`subscription-started` (10:35:08.095 to 10:35:09.503 UTC). The 235 notifications that arrived meanwhile were buffered
and then processed; none was dropped or sent with the default schema.

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
grep -c 'Successfully validated' collector.log     # 24818
grep -c 'skipping validation step' collector.log   # 0
grep -c 'Failed to validate' collector.log         # 177
grep -c 'Failed to decode' collector.log           # 3
grep 'Successfully validated' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*/\1 \2/' | sort | uniq -c
```
24,818 + 177 + 3 = 24,998, every complete notification of the capture. Validated per subscription
(SubscriptionTerminated / YangPushUpdate):
```
  1: 1/2550    2: 1/10195   3: 1/11521   4: 1/-     100: 1/-    101: 1/-    102: 1/-    104: 1/-    105: 1/1+1  106: 1/2
200: 1/10    201: 1/10    202: 1/10    203: 1/10   204: 1/10   205: 1/10   206: 1/10   207: 1/10   208: 1/30   209: 1/10
210: 1/10    211: 1/10    212: 1/10    213: 1/10   214: 1/10   215: 1/10   216: 1/4    217: 1/4    218: 1/10   219: 1/30
220: 1/40    300: 1/10    301: 1/40    302: 1/10   303: 1/10   304: 1/100  305: 1/-    306: 1/10   400: 1/9    401: 1/9
402: 1/29    403: 1/-     404: 1/-     405: 1/9
totals: 44 SubscriptionTerminated, 24773 YangPushUpdate, 1 YangPushChangeUpdate (105: 1 push-update + 1 push-change-update)
```
Subscription 4 sent no data. 100, 101, 102, 104, 305, 403 and 404 have no validated data notification, see below.

### Failed Examples - Notifications and Validation State for Each YANG-Push Subscription ID
```bash
grep 'Failed to validate' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*error=(.{0,110}).*/\1 \2 \3/' | sort | uniq -c | sort -k2 -n
```
```
 44 all  SubscriptionStarted   Node "datastore" not found as a child of "subscription-started" node.
 45 100  YangPushChangeUpdate  Invalid identityref "<id>" value - identity not found in module "ietf-alarms".
 22 101  YangPushChangeUpdate  Node "interface" not found in the "ietf-yang-push" module.
  1 101  YangPushUpdate        Unsatisfied length - string "" length is not allowed.
 13 102  YangPushChangeUpdate  Node "component" not found in the "ietf-yang-push" module.
  2 102  YangPushUpdate        Node "physical-index" not found as a child of "component" node.
  2 105  YangPushChangeUpdate  Node "remote-systems-data" not found in the "ietf-yang-push" module.
 10 305  YangPushUpdate        Node "hardware" not found in the "ietf-yang-push" module.
 10 403  YangPushUpdate        Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to map prefix to YANG schema.
 10 403  YangPushUpdate        Invalid identityref "iana-if-type:ppp" value - unable to map prefix to YANG schema.
 18 404  YangPushUpdate        Node "physical-index" not found as a child of "component" node.
```
All are device issues, and NetCalyx 0.4.0 rejects the same 177 notifications with the same errors:

* `subscription-started` (all 44): `huawei-ietf-subscribed-notifications-deviations-NE8000-F1A` deviates
  `/sn:subscription-started/sn:target` as not-supported, but the device sends `ietf-yang-push:datastore` and
  `ietf-yang-push:datastore-xpath-filter`. The subscription is still registered, so its data is validated.
* 100: `<id>` = `linkDown` (23), `hwBfdSessUp` (5), `hwBfdSessDown` (5), `LLDP_REMTABLECHANGE` (3),
  `hwLacpTotalLinkLoss`, `isisAdjacencyChange`, `vrrpTrapNonMaster` (2 each), `HARDWARE_OPER_STATE_DISABLE`,
  `HARDWARE_OPER_STATE_ENABLE`, `vrrpTrapMasterDown` (1 each): sent without module name, defined by no library module.
* 101, 102, 105 push-change-update: the yang-patch edit is `"value": {"interface": [...]}` (`"component"`,
  `"remote-systems-data"`), a node below the schema root without module name. The one validated push-change-update
  (105, message id 58) contains only `delete` edits, which have no `value`.
* 101 push-update: 58 interfaces with `"description": ""`; `huawei-ietf-interfaces-deviations-NE8000-F1A` replaces the
  type of `description` with `string { length "1..242"; }`.
* 102, 404 push-update: `physical-index` is `if-feature entity-mib` in `ietf-hardware@2018-03-13`; the YANG library
  lists no feature for `ietf-hardware`.
* 305 push-update: `"datastore-contents": {"hardware": ...}` without module name (Huawei VRP R026C00, issue 37).
* 403 push-update: `"type": "iana-if-type:..."` while `iana-if-type` is not part of the YANG library.

Three push-updates (stream to 138.187.58.50) are not valid JSON and are dropped before validation, by NetCalyx too:
```
WARN netgauze_yang_push::validation: Failed to decode UDP-Notif payload, dropping packet peer=127.0.0.62:60520 message_id=41 publisher_id=16843793 error=JSON error: control character (\u0000-\u001F) found while parsing a string at line 1 column 582
WARN ... message_id=42 ... error=JSON error: control character (\u0000-\u001F) found while parsing a string at line 2 column 0
WARN ... message_id=47 ... error=JSON error: invalid escape at line 1 column 3900
```
41 (subscription 104, its only push-update): raw CR LF in `"system-description":"Huawei Versatile Routing Platform
Software\r\nVRP (R) software ..."` (shown escaped here); 42 (105): raw LF in a neighbour's system description;
47 (102): `"uri":["urn:clei:\0","urn:item-code:\0", ...]`, and `\0` is not a JSON escape.

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 127.0.0.62 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
```
```
schema_id=616 content_id="453f4d25..."  subscriptions 1-4, 101, 200-205, 208-220, 301-304, 400-403
schema_id=625 content_id="8c492dc8..."  subscriptions 104, 105, 106, 405
schema_id=628 content_id="afbee089..."  subscriptions 206, 207
schema_id=631 content_id="ba7855ef..."  subscriptions 300, 306
schema_id=634 content_id="3f7191b4..."  subscription 100
schema_id=638 content_id="83e6ed2e..."  subscriptions 102, 305, 404
```
(100 and 102 are not in the grep output, see the producer readme.) Swisscom's run mapped the same content ids to
235571 / 236749 / 235572 / 235575 / 236414 / 236740.

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID
`yp-sNNN-<type>.json` in this directory, one per subscription and notification type, extracted from the messages
consumed from Kafka (`tools/extract-examples.py`): 44 `subscription-terminated`, 36 `push-update`, 1
`push-change-update` (105). There is no `subscription-started` example because they are rejected (see above).
```
2026-11-10T10:35:08.095297Z DEBUG netgauze_yang_push::validation: Received new subscription sending lookup by subscription info request to the cache peer=127.0.0.62:60520 message_id=1 publisher_id=16843793 subscription_id=100 ...
2026-11-10T10:35:08.095534Z  INFO netgauze_yang_push::cache::actor: cache hit: yang library reference found in cache peer=127.0.0.62 subscription_id=100 router_content_id="190100522" target={ datastore: ietf-datastores:operational, datastore-xpath-filter: /ietf-alarms:alarm-notification } cached_content_id="3f7191b4..."
2026-11-10T10:35:09.357261Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=127.0.0.62:60520 message_id=7 publisher_id=16843793 subscription_id=2 ... notification_type="YangPushUpdate"
2026-11-10T10:35:09.328414Z  WARN netgauze_yang_push::validation: Failed to validate UDP-Notif payload using draft-ietf-netconf-notif-envelope, dropping packet peer=127.0.0.62:60520 message_id=26 publisher_id=16843793 subscription_id=300 ... notification_type="SubscriptionStarted" error=Node "datastore" not found as a child of "subscription-started" node. ...
```
