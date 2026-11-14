## Blue Planet Java/AWE Titan Consumer Results

- **Latest replay:** November 13, 2026
- **Consumer:** deployed `KafkaYangJsonSchemaDeserializer` in AWE pod `uaa-awe-0`, app container
- **Topic:** `telemetry-yang`, partition 0
- **Offsets:** 52069-52131 (63 records; end offset exclusive 52132)
- **Host:** `ipt-age923-b-aac-01`
- **Schema Registry:** `http://10.190.33.167:8081`
- **Payload evidence:** Per-offset summaries and exact diagnostics are documented below. Raw Java audit logs are not stored in this repository.

The audit used group `titan-audit-live-20261113`, `auto.offset.reset=latest`,
and auto-commit disabled. The `schema-id` header was normalized from the
producer's ASCII decimal bytes to the deserializer's 4-byte integer header
format. The consumer began at offset 52069 and did not commit or change
`test-grp`.

### Latest Replay Results

| Payload event | Total | Passed | Failed |
|---|---:|---:|---:|
| `ietf-subscribed-notifications:subscription-started` | 14 | 14 | 0 |
| `ietf-yang-push:push-update` | 49 | 43 | 6 |
| **Total** | **63** | **57** | **6** |

There were no YANG Library content-id leafref failures and no missing
`module-name` failures in this replay. The 14 control payloads passed although
their `module-version` entries still use the `name` key; that earlier failure
did not recur in these offsets.

### Payload-by-Payload Results

Each row gives Kafka offset, collection timestamp, subscription ID, sequence,
event, schema ID, outcome, and payload summary. Raw JSON and full exception
stacks are not retained in this repository.

| Offset | Collection timestamp (UTC) | Sub | Seq | Event | Schema ID | Result | Payload summary / diagnostic |
|---:|---|---:|---:|---|---:|---|---|
| 52069 | 10:44:29.872714343Z | 81 | 0 | subscription-started | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper@2022-01-25 |
| 52070 | 10:44:30.579078984Z | 82 | 0 | subscription-started | 1687 | PASS | Cisco-IOS-XR-procmem-oper@2025-04-01 |
| 52071 | 10:44:30.579229816Z | 85 | 0 | subscription-started | 1690 | PASS | Cisco-IOS-XR-wdsysmon-fd-oper@2019-07-05 |
| 52072 | 10:44:30.579402314Z | 86 | 0 | subscription-started | 1694 | PASS | Cisco-IOS-XR-perf-meas-oper@2025-05-09 |
| 52073 | 10:44:30.579567887Z | 84 | 0 | subscription-started | 1696 | PASS | Cisco-IOS-XR-qos-ma-oper@2025-08-26 |
| 52074 | 10:44:30.579718206Z | 83 | 0 | subscription-started | 1696 | PASS | Cisco-IOS-XR-qos-ma-oper@2025-08-26 |
| 52075 | 10:44:30.579875956Z | 87 | 0 | subscription-started | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper@2022-11-01 |
| 52076 | 10:44:30.580035896Z | 88 | 0 | subscription-started | 1711 | PASS | Cisco-IOS-XR-platforms-ofa-oper@2025-04-17 |
| 52077 | 10:44:30.580180134Z | 89 | 0 | subscription-started | 1716 | PASS | Cisco-IOS-XR-ptp-oper@2024-11-19 |
| 52078 | 10:44:30.580322968Z | 92 | 0 | subscription-started | 1716 | PASS | Cisco-IOS-XR-ptp-oper@2024-11-19 |
| 52079 | 10:44:30.580482983Z | 90 | 0 | subscription-started | 1716 | PASS | Cisco-IOS-XR-ptp-oper@2024-11-19 |
| 52080 | 10:44:30.580625261Z | 93 | 0 | subscription-started | 1716 | PASS | Cisco-IOS-XR-ptp-oper@2024-11-19 |
| 52081 | 10:44:30.580766689Z | 91 | 0 | subscription-started | 1716 | PASS | Cisco-IOS-XR-ptp-oper@2024-03-19 |
| 52082 | 10:44:30.580909215Z | 94 | 0 | subscription-started | 1720 | PASS | Cisco-IOS-XR-freqsync-oper@2024-03-27 |
| 52083 | 10:44:42.847598006Z | 93 | 1 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52084 | 10:44:42.848120633Z | 91 | 1 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52085 | 10:44:42.848254519Z | 81 | 1 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52086 | 10:44:42.849297151Z | 87 | 1 | push-update | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib |
| 52087 | 10:44:42.849496329Z | 86 | 1 | push-update | 1694 | PASS | Cisco-IOS-XR-perf-meas-oper:performance-measurement |
| 52088 | 10:44:42.850683093Z | 89 | 1 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52089 | 10:44:42.851237407Z | 92 | 1 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52090 | 10:44:42.870114977Z | 91 | 2 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52091 | 10:44:42.870280229Z | 81 | 2 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52092 | 10:44:42.870491786Z | 90 | 2 | push-update | 1716 | FAIL | GE0/0/0/27 has 1 foreign-clock entry; TenGigE0/0/0/12 has 0 |
| 52093 | 10:44:42.871319863Z | 89 | 2 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52094 | 10:44:42.871672396Z | 92 | 2 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52095 | 10:44:46.389884898Z | 93 | 3 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52096 | 10:44:46.390867364Z | 91 | 3 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52097 | 10:44:46.393229715Z | 90 | 3 | push-update | 1716 | FAIL | GE0/0/0/27 has 1 foreign-clock entry; TenGigE0/0/0/12 has 0 |
| 52098 | 10:44:46.393981042Z | 86 | 3 | push-update | 1694 | PASS | Cisco-IOS-XR-perf-meas-oper:performance-measurement |
| 52099 | 10:44:46.396525303Z | 81 | 3 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52100 | 10:44:46.400986367Z | 87 | 3 | push-update | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib |
| 52101 | 10:44:46.407852507Z | 89 | 3 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52102 | 10:44:46.408827640Z | 92 | 3 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52103 | 10:44:52.381878749Z | 93 | 4 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52104 | 10:44:52.391529926Z | 91 | 4 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52105 | 10:44:52.391551699Z | 81 | 4 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52106 | 10:44:52.394910889Z | 90 | 4 | push-update | 1716 | FAIL | GE0/0/0/27 has 1 foreign-clock entry; TenGigE0/0/0/12 has 0 |
| 52107 | 10:44:52.399632212Z | 87 | 4 | push-update | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib |
| 52108 | 10:44:52.399972015Z | 89 | 4 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52109 | 10:44:52.439544784Z | 92 | 4 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52110 | 10:44:58.387030288Z | 91 | 5 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52111 | 10:44:58.387051558Z | 93 | 5 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52112 | 10:44:58.387082331Z | 81 | 5 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52113 | 10:44:58.389274530Z | 86 | 5 | push-update | 1694 | PASS | Cisco-IOS-XR-perf-meas-oper:performance-measurement |
| 52114 | 10:44:58.393594765Z | 87 | 5 | push-update | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib |
| 52115 | 10:44:58.399334342Z | 90 | 5 | push-update | 1716 | FAIL | GE0/0/0/27 has 1 foreign-clock entry; TenGigE0/0/0/12 has 0 |
| 52116 | 10:44:58.402009299Z | 89 | 5 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52117 | 10:44:58.422012308Z | 92 | 5 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52118 | 10:45:04.380263374Z | 93 | 6 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52119 | 10:45:04.393315022Z | 81 | 6 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52120 | 10:45:04.393939928Z | 90 | 6 | push-update | 1716 | FAIL | GE0/0/0/27 has 1 foreign-clock entry; TenGigE0/0/0/12 has 0 |
| 52121 | 10:45:04.398899009Z | 87 | 6 | push-update | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib |
| 52122 | 10:45:04.399819075Z | 91 | 6 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52123 | 10:45:04.401489517Z | 89 | 6 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52124 | 10:45:04.406102130Z | 92 | 6 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52125 | 10:45:10.387924550Z | 93 | 7 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52126 | 10:45:10.395390512Z | 81 | 7 | push-update | 1684 | PASS | Cisco-IOS-XR-nto-misc-oper:memory-summary |
| 52127 | 10:45:10.395869274Z | 91 | 7 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52128 | 10:45:10.396623475Z | 90 | 7 | push-update | 1716 | FAIL | GE0/0/0/27 has 1 foreign-clock entry; TenGigE0/0/0/12 has 0 |
| 52129 | 10:45:10.404496369Z | 87 | 7 | push-update | 1699 | PASS | Cisco-IOS-XR-lpts-pre-ifib-oper:lpts-pifib |
| 52130 | 10:45:10.405234799Z | 89 | 7 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |
| 52131 | 10:45:10.413872562Z | 92 | 7 | push-update | 1716 | PASS | Cisco-IOS-XR-ptp-oper:ptp |

### Failure Analysis

All six failures are subscription 90 `push-update` records (offsets 52092,
52097, 52106, 52115, 52120, 52128; sequences 2-7), schema ID 1716. Each contains
the keyed `node-interface-foreign-master` entries for
`GigabitEthernet0/0/0/27` (one nested `foreign-clock` entry) and
`TenGigE0/0/0/12` (empty `foreign-clock` list).

The exact repeated exception is:

```text
SerializationException: Error deserializing YANG-JSON message for id 1716
Caused by: NullPointerException: YangList.getKey() is null
at org.yangcentral.yangkit.data.codec.json.ListDataJsonCodec.buildData(ListDataJsonCodec.java:28)
```

Registry subject `netcalyx.labCisco-IOS-XR-ptp-oper` v1 defines the enclosing
`ptp` container with `config false`. Its `node-interface-foreign-master` list
is keyed by `interface-name`; the nested `foreign-clock` list in
`PTP-IF-CLOCK-INFO` has no `key` statement. This is legal for a config-false
YANG list. The payload supplies one valid list item, but YANGKit's
`ListDataJsonCodec` dereferences a missing key instead of decoding a legal
keyless state list. These are YANGKit deserialization failures, not malformed
producer payloads or Schema Registry retrieval failures.

The latest controls all passed, including their observed `module-version`
entries keyed by `name`; the previous run's `missing key:module-name` result did
not repeat. No YANG Library content-id leafref failures occurred.