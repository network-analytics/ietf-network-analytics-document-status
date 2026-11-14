## Blue Planet Java/AWE BNS Consumer Results

- **Latest replay:** November 13, 2026
- **Consumer:** Java `Solution.java` in the AWE `uaa-awe-0` app container
- **Topic:** `telemetry-yang`, partition 0
- **Offsets:** 52051-52068 (18 records; end offset exclusive 52069)
- **Host:** `daisy-ietf-ipf-zbl1843-r-daisy-58`
- **Schema Registry:** `http://10.190.33.167:8081`
- **Payload evidence:** Offset-level payload identities and failure details are included below. Raw Java audit logs are not stored in this repository.

### Latest Replay Results

| Payload event | Total | Passed | Failed |
|---|---:|---:|---:|
| `ietf-subscribed-notifications:subscription-started` | 5 | 5 | 0 |
| `ietf-yang-push:push-update` | 13 | 7 | 6 |
| **Total** | **18** | **12** | **6** |

No YANG Library content-id leafref errors occurred in this replay. The six
failures are all subscription 101 interface updates rejected for missing
mandatory `if:statistics`, schema ID 1589. `test-grp` committed through offset
52069, matching the partition end.

The AWE payload capture listed each record's payload, but its own `STATUS=PASS`
markers came from a parse-only run with `yang.json.fail.invalid.schema` disabled. Those
markers are not validation outcomes. The PASS/FAIL results below use the
separately verified Java/AWE validation result, aligned with the captured Kafka
offset, timestamp, subscription, and sequence.

### Payload-by-Payload Results

| Offset | Collection timestamp (UTC) | Sub | Seq | Event | Schema ID | Result | Payload detail / diagnostic |
|---:|---|---:|---:|---|---:|---|---|
| 52051 | 07:20:36.420176343Z | 103 | 6889 | subscription-started | 1588 | PASS | `ietf-hardware@2018-03-13` |
| 52052 | 07:20:39.123907604Z | 100 | 6886 | subscription-started | 1589 | PASS | `ietf-interfaces@2018-02-20` |
| 52053 | 07:20:39.124002941Z | 102 | 6888 | subscription-started | 1588 | PASS | `ietf-hardware@2018-03-13` |
| 52054 | 07:20:39.125901640Z | 102 | 6893 | push-update | 1588 | PASS | 132 `ietf-hardware:hardware/component` entries; samples cpu:0, cpu:1, cpu:10, cpu:100, cpu:101 |
| 52055 | 07:20:39.126413984Z | 101 | 6887 | subscription-started | 1589 | PASS | `ietf-interfaces@2018-02-20` |
| 52056 | 07:20:39.126450720Z | 104 | 6890 | subscription-started | 1591 | PASS | `ietf-alarms@2019-09-11` |
| 52057 | 07:20:40.742984029Z | 101 | 6899 | push-update | 1589 | FAIL | `Loopback-A9-main` lacks `statistics`; `data-missing`, mandatory `if:statistics` |
| 52058 | 07:20:41.312224854Z | 103 | 6901 | push-update | 1588 | PASS | Empty `datastore-contents` |
| 52059 | 07:20:46.743988061Z | 101 | 6906 | push-update | 1589 | FAIL | `Loopback-A9-main` lacks `statistics`; `data-missing`, mandatory `if:statistics` |
| 52060 | 07:20:47.507654769Z | 103 | 6908 | push-update | 1588 | PASS | Empty `datastore-contents` |
| 52061 | 07:20:52.744531869Z | 101 | 6913 | push-update | 1589 | FAIL | `Loopback-A9-main` and `Loppback-A9-A9` lack `statistics`; `data-missing`, mandatory `if:statistics` |
| 52062 | 07:20:53.707311178Z | 103 | 6915 | push-update | 1588 | PASS | Empty `datastore-contents` |
| 52063 | 07:20:58.744827901Z | 101 | 6920 | push-update | 1589 | FAIL | `Loopback-A9-main` lacks `statistics`; `data-missing`, mandatory `if:statistics` |
| 52064 | 07:20:59.906252685Z | 103 | 6922 | push-update | 1588 | PASS | Empty `datastore-contents` |
| 52065 | 07:21:04.744432063Z | 101 | 6927 | push-update | 1589 | FAIL | `Loopback-A9-main` lacks `statistics`; `data-missing`, mandatory `if:statistics` |
| 52066 | 07:21:06.097341974Z | 103 | 6929 | push-update | 1588 | PASS | Empty `datastore-contents` |
| 52067 | 07:21:10.744116091Z | 101 | 6934 | push-update | 1589 | FAIL | `Loopback-A9-main` lacks `statistics`; `data-missing`, mandatory `if:statistics` |
| 52068 | 07:21:12.291107065Z | 103 | 6936 | push-update | 1588 | PASS | Empty `datastore-contents` |

### Failure Analysis

The selected XPath for subscription 101 is
`/ietf-interfaces:interfaces/interface/statistics`. The six failed updates
include interface entries but omit their requested statistics data. The
diagnostic is `errorTag=data-missing` with
`errorMessage=missing mandatory schema node:if:statistics`. Schema 1589's
effective Registry closure includes `ietf-interfaces` v4, where `statistics`
is a non-presence container containing mandatory `discontinuity-time`.

This replay had **zero** YANG Library content-id leafref failures.

### Evidence Boundary

The exact consumer-side validation log for this latest replay is not retained
in the repository. The per-payload content and Kafka identities above were
extracted from the AWE capture log, while the result and diagnostic fields are
from the separately verified Java/AWE validation of the same BNS window. The
parse-only capture status was not treated as validation evidence.