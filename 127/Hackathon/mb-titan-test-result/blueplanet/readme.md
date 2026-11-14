## Titan Blueplanet Integration Test Results

Server-side evidence collected on **2026-11-12** from `10.190.33.167`.
NetCalyx 0.3.0 replayed the Titan capture to Kafka topic `telemetry-yang`.

| Component | Test | Result |
| --- | --- | --- |
| Publisher | Titan PCAP replay | Partial evidence: 126 matching Kafka records at offsets 47799-47924; original replay stdout was not retained, so full replay completion is not independently confirmed |
| Receiver | YANG-Push validation | Partial: 306 validation-drop events in captured journal excerpt |
| Producer | Kafka messages | Partial: 126 records for subscriptions 81-94, including 98 push updates and 28 subscription-started records |
| Schema Registry | Schema availability and registration | Partial: 9 observed IDs and 83 referenced versions exported; 390 HTTP 422 responses for a Cisco XR YANG subject |
| Blueplanet consumer | Deserialize and validate | Latest Nov 13 Titan audit: offsets 52069-52131, 63 records; 57 passed and 6 subscription 90 PTP updates failed in YANGKit's keyless-list decoder. All 14 controls passed; no YANG Library leafref errors. See the [consumer report](blueplanet-messagebroker-consumer/readme.md). |
| Blueplanet consumer | Mock telemetry fixtures | Not included in the captured Titan run |

### Evidence

- [Publisher capture and replay settings](netcalyx-yangpush-publisher/readme.md)
- [Producer schema mappings and Kafka samples](netcalyx-messagebroker-producer/readme.md)
- [Receiver cache and validation details](netcalyx-yangpush-receiver/readme.md)
- [Schema Registry responses and errors](yang-schema-registry/readme.md)
- [Blueplanet Java/AWE consumer results](blueplanet-messagebroker-consumer/readme.md)
- [Machine-readable evidence summary](evidence-summary.json)
- [SHA-256 manifest](sha256.json)

The 126 Kafka records are a retained offset-range observation, not a count of
unique source notifications. The PCAP contains 6,075 UDP packets; replay stdout
was not saved, so full PCAP completion and its process exit status are not
verified. Some notifications were dropped by receiver validation, and some
producer attempts failed during schema registration. Blueplanet consumer results
are separate from NetCalyx receiver/producer outcomes.