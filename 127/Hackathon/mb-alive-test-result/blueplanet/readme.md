## Test Result Summary for YANG Message Broker Consumer Integration Testing

| Component       | Name       | Test Case                                                                           | Passed/Failed/Partial |
|-----------------|------------|-------------------------------------------------------------------------------------|-----------------------|
| Consumer        | Blue Planet | Latest ALIVE replay: telemetry messages received                                    | 2,077 payloads at offsets 52132-54208 from 12 subscriptions; no payloads for subscriptions 6, 8-12, and 15 were captured |
| Consumer        | Blue Planet | Latest ALIVE replay: YANG payloads deserialized                                     | 1,738 passed; 339 failed, all with schema ID 630 |
| Schema Registry | Apache Kafka | Latest ALIVE schema ID 630 evidence                                                | Resolves as YANG; its direct references omit `ietf-hardware` and `ietf-alarms`. See the Registry evidence. |
| Consumer        | Blue Planet | Latest ALIVE replay: subscription notifications validated                           | Four captured subscription-started controls passed; zero YANG Library content-id leafref errors |
| Consumer        | Blue Planet | Mockup Telemetry Messages validated                                                 | Not evaluated in this ALIVE replay |

### Latest ALIVE Consumer Replay

Latest replay: November 13, 2026. Topic: `telemetry-yang`, partition 0, offsets
52132-54208 (end offset exclusive 54209). Host: `ipf-zbl1327-r-daisy-48`.
Runtime JAR MD5: `9794325d69541a0d2e5eb6df297661f2`.

The latest run contained 2,077 payload attempts: 1,738 consumed and 339 failed,
all under schema ID 630. The four subscription-started controls passed; no YANG
Library content-id leafref failures occurred. `test-grp` committed through
54209, matching the partition end.

All 339 failed records reported `unknown-element` under schema ID 630. The
failures split between hardware `/component` content (317 records) and alarm
notification fields (22 records). Schema 630 directly omits `ietf-hardware` and
`ietf-alarms`; this run had no control leafref failures. The [consumer report](blueplanet-messagebroker-consumer/readme.md) has the per-subscription counts and error-path totals; the [Registry evidence](yang-schema-registry/readme.md) records schema 630's direct references.