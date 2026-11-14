## Blue Planet Java/AWE ALIVE Consumer Results

- **Latest replay:** November 13, 2026
- **Topic:** `telemetry-yang`, partition 0
- **Offsets:** 52132-54208 (end offset exclusive 54209)
- **Host:** `ipf-zbl1327-r-daisy-48`
- **Runtime JAR MD5:** `9794325d69541a0d2e5eb6df297661f2`
- **Consumer group:** `test-grp`

### Latest Replay Results

| Payload event | Total | Passed | Failed |
|---|---:|---:|---:|
| `ietf-subscribed-notifications:subscription-started` | 4 | 4 | 0 |
| `ietf-yang-push:push-update` | 2049 | 1732 | 317 |
| `ietf-yang-push:push-change-update` | 24 | 2 | 22 |
| **Total** | **2077** | **1738** | **339** |

All 339 failures used schema ID 630 and reported `errorTag=unknown-element`.
There were **zero YANG Library content-id leafref errors** in this replay. The
four captured subscription-started controls for subscriptions 7, 13, 14, and 19
all passed. The consumer committed through offset 54209, matching the partition
end.

### Results by Subscription

| Subscription | Attempts | Passed | Failed | Result |
|---:|---:|---:|---:|---|
| 1 | 82 | 82 | 0 | PASS |
| 2 | 82 | 82 | 0 | PASS |
| 3 | 324 | 324 | 0 | PASS |
| 4 | 81 | 81 | 0 | PASS |
| 5 | 999 | 999 | 0 | PASS |
| 7 | 82 | 1 | 81 | Hardware sensor updates fail on unknown `/component` elements under schema 630; control passed. |
| 13 | 3 | 1 | 2 | Hardware component updates fail on unknown `/component` elements under schema 630; control passed. |
| 14 | 235 | 1 | 234 | Hardware component updates fail on unknown `/component` elements under schema 630; control passed. |
| 16 | 82 | 82 | 0 | PASS |
| 17 | 2 | 2 | 0 | PASS |
| 18 | 82 | 82 | 0 | PASS |
| 19 | 23 | 1 | 22 | Alarm `push-change-update` values fail on unknown alarm elements under schema 630; control passed. |
| **Total** | **2077** | **1738** | **339** | |

Subscriptions 6, 8-12, and 15 were not observed in this replay.

### Failure Details

The 317 hardware failures are `unknown-element` diagnostics at `/component` for
subscriptions 7, 13, and 14. The 22 subscription 19 alarm updates each have
unknown elements at `/time`, `/resource`, `/perceived-severity`,
`/alt-resource`, `/alarm-type-id`, and `/alarm-text`; six diagnostics also
include `/alarm-type-qualifier`. These are 339 failed payloads and 455
diagnostic entries, since a single payload can emit multiple unknown-element
diagnostics.

All failed payloads use schema ID 630. The Schema Registry response identifies
it as YANG; its direct references do not include `ietf-hardware` or
`ietf-alarms`. See the [ALIVE Registry evidence](../yang-schema-registry/readme.md)
for the exact direct reference list and read-only query. No ALIVE Java log was
copied into this repository.