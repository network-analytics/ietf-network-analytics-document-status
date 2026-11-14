## YANG-Push Receiver - Message and YANG Schema Production

Receiver: `netgauze-collector`, NetGauze 0.14, configuration `config-lab.yaml` (this directory): UDP-Notif listener
`127.0.0.1:8123`, `anydata_strict_validation: true`, replayed peer `127.0.0.79`. Log: `fano-netgauze-receiver-log.tar.gz`
(`collector.log`, `netgauze_collector=trace,netgauze_yang_push=trace,info`).

### Receiver content
Swisscom's cache content (`../../netcalyx/netcalyx-yangpush-receiver/fano-netcalyx-receiver-cache-content.tar.gz`)
converted with `tools/convert-netcalyx-cache.py` (peer remapped to `127.0.0.79`), same three content ids.
```bash
tar -xzf fano-netgauze-receiver-cache-content.tar.gz     # <content-id>/{yang-lib.xml,modules/,subscriptions-info.json}
grep 127.0.0.79 collector.log | grep 'cache hit' | sed -E 's/.*subscription_id=([0-9]+) .*cached_content_id="([0-9a-f]+)".*/\2 \1/' | sort -k1,1 -k2,2n

38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482   subscriptions 1-5, 12-26   352 modules
53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061   subscriptions 6-11         353 modules
f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521   subscription 27            359 modules
```
All 27 subscriptions are answered from the cache (27 `cache hit` lines); the device announces
`router_content_id="22934"` for every subscription. One libyang context is built per content id and shared by its
subscriptions.

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
grep -c 'Successfully validated' collector.log      # 7298
grep -c 'skipping validation step' collector.log    # 0
grep -c 'Failed to validate' collector.log          # 448
grep 'Successfully validated' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*/\1 \2/' | sort | uniq -c
```
Validated notifications per subscription (SubscriptionStarted / YangPushUpdate); 27 + 7,271 = 7,298:
```
 1: 1/326    2: 1/41     3: 1/42     4: 1/42     5: 1/6120   6: 1/218    7: 1/-      8: 1/43     9: 1/-
10: 1/42    11: 1/-     12: 1/44    13: 1/43    14: 1/43    15: 1/21    16: 1/108   17: 1/108   18: 1/20
19: 1/2     20: 1/2     21: 1/1     22: 1/1     23: 1/1     24: 1/1     25: 1/1     26: 1/1     27: 1/-
```
Rejected and dropped notifications (448 = 431 push-update + 17 push-change-update):
```bash
grep 'Failed to validate' collector.log | sed -E 's/.*subscription_id=([0-9]+).*notification_type="([A-Za-z]+)".*error=(.*)/\1 \2 \3/; s/ packet=.*//; s/value "-?[0-9]+"/value "<N>"/' | sort | uniq -c | sort -k2 -n

    218 7 YangPushUpdate Invalid union value "<N>" - no matching subtype found:
    171 9 YangPushUpdate Invalid union value "<N>" - no matching subtype found:
     42 11 YangPushUpdate Invalid union value "<N>" - no matching subtype found:
     17 27 YangPushChangeUpdate No module named "huawei-alarm-type-an" in the context.
```
Subscriptions 7, 9, 11 and 27 therefore have a validated `subscription-started` but no validated data notification.
NetCalyx 0.4.0 rejects the same 448 notifications with the same errors.

- **Subscriptions 7, 9, 11** (`/ietf-hardware:hardware/component[huawei-hardware:sub-class=...]/`
  `bbf-hardware-transceivers:transceiver-link`, sub-class `ethernetCsmacd-xcvr-link`, `pon-xcvr-link`,
  `ont-ani-xcvr-link`): every push-update is rejected. Full error:
  ```
  Invalid union value "-5000" - no matching subtype found:
      ly2 enumeration: Invalid non-string-encoded enumeration value "-5000".
      ly2 decimal64: Invalid non-string-encoded decimal64 value "-5000".
  ```
  The leaves are `diagnostics/power-dbm/transmit` and `receive`, type `power-dbm` of
  `bbf-hardware-transceivers@2025-01-27`: a union of an enumeration (`undetermined`) and a `decimal64` with
  `fraction-digits 4` and `range "-40..20"`. The device sends bare JSON numbers
  (`"power-dbm":{"transmit":-5000,"receive":-4000}`); RFC 7951 requires a decimal64 to be encoded as a string, and all
  40 distinct values in the error lines (-5000 ... 1022) are outside the range as well.
- **Subscription 27** (`/ietf-alarms:alarm-notification`, on-change): all 17 push-change-updates are rejected. The
  payload carries `"huawei-alarm-type-an:alarm-type-id":"hw-alarm-type-an:managing-user-login-logout"`; the module
  `huawei-alarm-type-an` is listed in the device's YANG library
  (`../netgauze-yangpush-publisher/ipd-zbl1536-s-ah-79-netconf-yang-library-20261020-1602.xml`) but is not among the
  359 modules of content id `f0961ff3...`, and the `subscription-started` announces only `ietf-alarms@2019-09-11`.

The first data packets of subscriptions 19 (2), 21, 23, 25 and 27 (2) arrive while the schema lookup triggered by their
`subscription-started` is pending; they are buffered and validated once the cache answers:
```bash
grep -c 'buffering packet until the cache answers' collector.log    # 7
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 127.0.0.79 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n

subscription_id=1..5, 12..26  schema_id=391 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=6..11         schema_id=390 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
```
The output has one line per subscription (26 lines, condensed here). Subscription 27 (content id `f0961ff3...`, schema
id 399) is not printed by this grep, see `../netgauze-messagebroker-producer/readme.md`. Swisscom's registry mapped the
same content ids to schema ids 236779 / 236781 / 236780.

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID
`yp-sNNN-subscription-started.json` for all 27 subscriptions and `yp-sNNN-push-update.json` for the 23 subscriptions
with a validated push-update (none for 7, 9, 11, 27), extracted from the messages consumed from Kafka.
```
2026-11-10T13:33:31.035688Z  INFO netgauze_yang_push::cache::actor: cache hit: yang library reference found in cache peer=127.0.0.79 subscription_id=19 router_content_id="22934" target={...} cached_content_id="38ef2138..."
2026-11-10T13:33:31.240373Z TRACE netgauze_yang_push::validation: Successfully validated YANG-Push message using draft-ietf-netconf-notif-envelope peer=127.0.0.79:45389 message_id=18 publisher_id=3021116857 subscription_id=19 router_content_id="22934" target={...} notification_type="SubscriptionStarted" cached_content_id="38ef2138..."
2026-11-10T13:33:33.612177Z  WARN netgauze_yang_push::validation: Failed to validate UDP-Notif payload using draft-ietf-netconf-notif-envelope, dropping packet peer=127.0.0.79:45389 message_id=37313 publisher_id=3021116866 subscription_id=7 router_content_id="22934" target={...} cached_content_id="53af9564..." notification_type="YangPushUpdate" error=Invalid union value "-5000" - no matching subtype found:
2026-11-10T13:33:31.558069Z  WARN netgauze_yang_push::validation: Failed to validate UDP-Notif payload using draft-ietf-netconf-notif-envelope, dropping packet peer=127.0.0.79:45389 message_id=31 publisher_id=3021116857 subscription_id=27 router_content_id="22934" target={...} cached_content_id="f0961ff3..." notification_type="YangPushChangeUpdate" error=No module named "huawei-alarm-type-an" in the context.
```
(`target={...}` and the content ids are shortened here.)
