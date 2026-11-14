## Blueplanet eBNG Consumer Evidence

Replay: November 12, 2026. Topic: `telemetry-yang`; partition 0, offsets
50988-51987. Original consumer log path on the AWE pod: `/bp2/data/consumer-ebng-validation.log`.
The deployed `kafka-yang-json-schema-serializer-0.0.6-shaded.jar` SHA-256 was
`91aae38f1ba72a0e964bc47de5d4defd402a4ca17e201c827e16b7c528be595b`.

This remains the latest comparable validation. A Nov 13 re-read was not
substituted because the available pod classpath used
`kafka-yang-json-schema-serializer-0.0.5.jar`; its outcomes are not comparable
to the deployed consumer run.

The original validated `/bp2/data/consumer-ebng-validation.log` and the deployed
`0.0.6-shaded` JAR are no longer present on the AWE pod and were not archived in
this repository. The per-subscription counts, failure categories, and
representative schema-differential probes below are the retained evidence; an
exact raw payload/exception row for every failed attempt cannot be reconstructed
from the available non-comparable Nov 13 audit.

| Outcome | Count |
| --- | ---: |
| Payload attempts | 1,000 |
| Deserialized and consumed | 130 |
| Deserialization failures | 870 |
| Failure schema ID | 630 for all 870 failures |

The consumer used group `test-grp`. The payload results below were matched by
subscription ID and message metadata.

### Results by Subscription

| Subscription | Attempts | Consumed | Failed | Result / principal reason |
| --- | ---: | ---: | ---: | --- |
| 1 | 100 | 1 | 99 | FAIL: `huawei-bras-user-manage` `/access-tables`; module absent from schema 630. |
| 2 | 100 | 1 | 99 | FAIL: `huawei-bras-user-manage` `/access-tables`; module absent from schema 630. |
| 3 | 100 | 1 | 99 | FAIL: `huawei-bras-user-manage` `/access-tables`; module absent from schema 630. |
| 4 | 2 | 2 | 0 | PASS: all captured payloads consumed. |
| 100 | 47 | 2 | 45 | FAIL: alarm notification in yang-patch value; unknown alarm fields under 630. Under 1591 the representative fails on invalid `alarm-type-id`. |
| 101 | 25 | 24 | 1 | FAIL: one selected interface payload omits required `statistics` data. |
| 102 | 17 | 15 | 2 | FAIL: `ietf-hardware` `/component` absent from schema 630; one checked sample has empty `uuid` under 1588. |
| 104 | 2 | 2 | 0 | PASS: all captured payloads consumed. |
| 105 | 6 | 5 | 1 | FAIL: LLDP `/port`; module absent from schema 630. |
| 106 | 4 | 2 | 2 | FAIL: LLDP `/port`; module absent from schema 630. |
| 200 | 12 | 2 | 10 | FAIL: `huawei-bras-dhcp-access` `/dhcp-access-statistics`; module absent from schema 630. |
| 201 | 12 | 2 | 10 | FAIL: `huawei-bras-dhcp-server` `/dhcp-servers`; module absent from schema 630. |
| 202 | 12 | 2 | 10 | FAIL: `huawei-bras-dhcpv6-access` `/dhcpv6-packets-statistics`; module absent from schema 630. |
| 203 | 12 | 2 | 10 | FAIL: `huawei-radius` `/authentication-packet-statistics`; module absent from schema 630. |
| 204 | 12 | 2 | 10 | FAIL: `huawei-radius` `/account-packet-statistics`; module absent from schema 630. |
| 205 | 12 | 2 | 10 | FAIL: `huawei-radius` `/author-packet-statistics`; module absent from schema 630. |
| 206 | 12 | 2 | 10 | FAIL: `huawei-bras-user-statistic` `/access-user`; module absent and its Registry subject is HTTP 404. |
| 207 | 12 | 2 | 10 | FAIL: `huawei-bras-user-statistic` `/access-user`; module absent and its Registry subject is HTTP 404. |
| 208 | 32 | 2 | 30 | FAIL: `huawei-bras-user-manage` `/domain-statistics`; module absent from schema 630. |
| 209 | 12 | 2 | 10 | FAIL: `huawei-ifm` `/interfaces`; module absent from schema 630. |
| 210 | 12 | 2 | 10 | FAIL: `huawei-bras-l2tp-access` `/lac-tunnels`; module absent from schema 630. |
| 211 | 12 | 2 | 10 | FAIL: `huawei-bras-l2tp-access` `/lac-tunnels`; module absent from schema 630. |
| 212 | 11 | 1 | 10 | FAIL: `huawei-bras-l2tp-access` `/lac-tunnels`; module absent from schema 630. |
| 213 | 11 | 1 | 10 | FAIL: `huawei-bras-l2tp-access` `/lac-tunnel-statistics`; module absent from schema 630. |
| 214 | 11 | 1 | 10 | FAIL: `huawei-cgn` `/user-table-usages`; module absent from schema 630. |
| 215 | 11 | 1 | 10 | FAIL: `huawei-cgn` `/session-table-usages`; module absent from schema 630. |
| 216 | 5 | 1 | 4 | FAIL: `huawei-cgn` `/user-tables`; module absent from schema 630. |
| 217 | 5 | 1 | 4 | FAIL: `huawei-cgn` `/session-tables`; module absent from schema 630. |
| 218 | 11 | 1 | 10 | FAIL: `huawei-bras-ipv4-address-manage` `/pool-usage-statistics`; module absent from schema 630. |
| 219 | 31 | 1 | 30 | FAIL: `huawei-bras-ipv6-address-manage` `/ipv6-pools`; module absent from schema 630. |
| 220 | 41 | 1 | 40 | FAIL: `huawei-cpudefend` `/cpcar`; module absent from schema 630. |
| 300 | 11 | 1 | 10 | FAIL: `huawei-debug` `/board-resouce-states`; module absent from schema 630. |
| 301 | 41 | 1 | 40 | FAIL: `huawei-devm` `/physical-entitys`; module absent from schema 630. |
| 302 | 11 | 1 | 10 | FAIL: `huawei-devm` `/chassiss`; module absent from schema 630. |
| 303 | 11 | 1 | 10 | FAIL: `huawei-devm` `/ports` with `huawei-pic` augmentation; required modules absent from schema 630. |
| 304 | 100 | 1 | 99 | FAIL: `huawei-devm` `/ports` with `huawei-pic` augmentation; required module absent from schema 630. |
| 305 | 11 | 1 | 10 | FAIL: top-level `hardware` is unqualified; payload should use `ietf-hardware:hardware`. |
| 306 | 11 | 1 | 10 | FAIL: `huawei-debug` `/board-cpu-core-infos`; module absent from schema 630. |
| 400 | 10 | 1 | 9 | FAIL: `huawei-ifm` `/interfaces`; module absent from schema 630. |
| 401 | 10 | 1 | 9 | FAIL: `huawei-ifm` `/interfaces`; module absent from schema 630. |
| 402 | 30 | 30 | 0 | PASS: all captured payloads consumed. |
| 403 | 21 | 1 | 20 | FAIL: selected interfaces omit required `statistics` data. |
| 404 | 19 | 1 | 18 | FAIL: `ietf-hardware` `/component` absent from schema 630; selected hardware payloads also contain empty UUID values. |
| 405 | 10 | 1 | 9 | FAIL: LLDP `/local-system-data`; module absent from schema 630. |

### Schema Registry Evidence

Schema ID 630 returned 11 direct references and 35 subject-version references
recursively. It includes `ietf-interfaces`, but excludes `ietf-hardware`,
`ietf-alarms`, the Huawei modules in the payloads, and `ieee802-dot1ab-lldp`.
849 failed payloads advertised at least one module outside this closure. Missing
module counts: `huawei-bras-user-manage` 327; `huawei-pic` 109; `ietf-alarms`
45; `huawei-devm` 40; `huawei-bras-l2tp-access` 40; `huawei-cpudefend` 40;
`ietf-hardware` 30; `huawei-radius` 30; `huawei-bras-ipv6-address-manage` 30;
`huawei-cgn` 28; `huawei-bras-user-statistic` 20; `huawei-debug` 20;
`huawei-ifm` 18; `ieee802-dot1ab-lldp` 12; `huawei-bras-dhcp-server` 10;
`huawei-bras-ipv4-address-manage` 10; `huawei-bras-basic-access` 10;
`huawei-driver` 10; `huawei-bras-dhcpv6-access` 10; `huawei-bras-dhcp-access`
10.

Run these read-only checks in the AWE app container:

```bash
curl -fsS http://10.190.33.167:8081/schemas/ids/630 | jq '{id, directReferences: [.references[] | {name, subject, version}]}'
curl -sS -o /dev/null -w 'ietf-hardware HTTP %{http_code}\n' http://10.190.33.167:8081/subjects/netcalyx.labietf-hardware/versions/latest
curl -sS -o /dev/null -w 'ietf-alarms HTTP %{http_code}\n' http://10.190.33.167:8081/subjects/netcalyx.labietf-alarms/versions/latest
curl -sS -o /dev/null -w 'huawei-devm HTTP %{http_code}\n' http://10.190.33.167:8081/subjects/huawei-devm/versions/latest
curl -sS -o /dev/null -w 'huawei-pic HTTP %{http_code}\n' http://10.190.33.167:8081/subjects/huawei-pic/versions/latest
curl -sS -o /dev/null -w 'huawei-bras-user-statistic HTTP %{http_code}\n' http://10.190.33.167:8081/subjects/huawei-bras-user-statistic/versions/latest
curl -fsS http://10.190.33.167:8081/subjects/netcalyx.labietf-interfaces/versions/1 | jq -r .schema | sed -n '411,425p'
```

Observed: schema 630 has 11 direct and 35 recursive references; the hardware,
alarms, devm, and pic subjects return HTTP 200 but are outside its closure;
the bras-user-statistic subject returns 404. The interface schema defines
mandatory `discontinuity-time` inside the non-presence `statistics` container.
`SchemaNodeSupport.isMandatory()` derives the container's mandatory state from
its mandatory child, and the subscription filter selects that interface
subtree. Omitting `statistics` is therefore expected validation failure.

### Same-Payload Schema Comparison

The pod probe calls `YangSchema.validate` using a selected Registry schema ID.
Representative commands (run in `/tmp/probe`):

```bash
java -cp "/bp2/src/lib/*" Probe.java 630 /bp2/data/consumer-ebng-validation.log 343 3156
java -cp "/bp2/src/lib/*" Probe.java 1555 /bp2/data/consumer-ebng-validation.log 343 3156
java -cp "/bp2/src/lib/*" Probe.java 1588 /bp2/data/consumer-ebng-validation.log 2355 2694
java -cp "/bp2/src/lib/*" Probe.java 1591 /bp2/data/consumer-ebng-validation.log 3825
```

Schema 630 loaded 35 modules (zero Huawei modules; no hardware, alarms, or
LLDP). Schema 1555 loaded 590 modules including 549 Huawei modules and LLDP;
lines 343 (Huawei ports) and 3156 (Huawei DHCP statistics) fail under 630 and
pass under 1555. Schema 1588 includes hardware; line 2694 changes from
`unknown-element /component` under 630 to PASS. Line 2355 changes from
`unknown-element` to invalid empty UUID under 1588. Schema 1591 includes alarms;
line 3825 changes from `unknown-element` to invalid `alarm-type-id`
`LLDP_REMTABLECHANGE`. These same-record comparisons show that supplying
missing model context removes the `unknown-element` failure while exposing
payload defects where present.

### Payload Issues and Limits

- 45 subscription-100 values target `/ietf-alarms:alarm-notification` in
	yang-patch. Notification content is not a datastore edit; under schema 1591,
	the representative also fails on invalid identity `LLDP_REMTABLECHANGE`.
- 10 subscription-305 payloads use unqualified top-level `hardware` instead of
	`ietf-hardware:hardware`; the example still fails with ietf-hardware loaded.
- Two failed qualified hardware payloads contain empty `uuid` values (73
	affected components); schema 1588 reports invalid value for the representative.
- 21 interface updates omit `statistics` from selected interface entries; the
	mandatory child constraint applies to the selected subtree.

The 849 closure-mismatch count comes from comparing each failed payload's
advertised modules with schema 630's recursive Registry closure. Cross-schema
validation covered representative Huawei, DHCP, hardware, and alarm records,
not all 849 individually. LLDP is outside schema 630; the alternate-schema LLDP
probe did not complete, so its differential behavior is not claimed. No
leafref or false yang-patch mandatory-node failures appeared in this capture.


