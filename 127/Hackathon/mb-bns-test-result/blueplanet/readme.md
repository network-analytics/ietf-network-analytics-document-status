## BNS Blueplanet Integration Test Results

The latest Blueplanet Java/AWE consumer replay is **2026-11-13**. The
publisher, receiver, producer, and Registry observations below are retained
from the separate **2026-11-11** NetCalyx run on `10.190.33.167` and are
historical, not outcomes of the latest consumer replay. Kafka topic:
`telemetry-yang`; broker: `10.190.33.167:9092`; YANG Schema Registry:
`http://10.190.33.167:8081` (HTTP/plaintext).

| Component | Test | Result |
| --- | --- | --- |
| Receiver | Prepared BNS receiver cache and replay peer | Passed: 14 subscription records across five cache trees; peer `10.190.33.167` |
| Publisher | Full BNS PCAP replay | Passed: 60 UDP packets sent, replay exit 0, about 37 seconds at 10x |
| Receiver | Notifications received | Partial: traffic reached receiver; two validation drops recorded |
| Receiver | Notifications validated | Partial: BNS identityref values were unresolved in two payloads |
| Producer | Messages produced to Kafka | Partial: 18 records, offsets 47781-47798, for subscriptions 100-104 |
| Schema Registry | Obtain schemas and references | Partial: IDs 1588, 1589, 1591 and 40 referenced versions exported; `vrouter-aaa` registration returned HTTP 422 |
| Blueplanet Java/AWE consumer | Receive and validate BNS messages | Latest Nov 13 window: offsets 52051-52068, 18 payloads; 12 passed and 6 subscription 101 interface updates failed for missing mandatory `if:statistics`. See the [consumer report](blueplanet-messagebroker-consumer/readme.md). |
| Blueplanet consumer | Validate mock telemetry fixtures | Not run |

### Result Artifacts

- [Publisher replay settings and log](netcalyx-yangpush-publisher/readme.md)
- [Producer records and schema mapping](netcalyx-messagebroker-producer/readme.md)
- [Receiver cache and validation log](netcalyx-yangpush-receiver/readme.md)
- [Registry schema exports and errors](yang-schema-registry/readme.md)
- [Blueplanet Java/AWE consumer results and failure analysis](blueplanet-messagebroker-consumer/readme.md)
- [Machine-readable evidence summary](evidence-summary.json)
- [SHA-256 manifest](sha256.json)

The Blueplanet Java/AWE run is separate from the NetCalyx receiver validation.
The Java/AWE counts and errors come from its AWE log; receiver success/failure
traces are reported separately and are not substituted for Java consumer results.