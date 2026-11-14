## eBNG Blueplanet Integration Test Results

Lab server `10.190.33.167`; Kafka topic `telemetry-yang`; Schema Registry
`http://10.190.33.167:8081`. The sender and collector observations below are
from separate replays on 2026-11-12.

| Component | Result |
| --- | --- |
| Publisher | Earlier replay: 37,337 UDP packets reported sent, exit 0. Sender counts do not prove receiver acceptance. |
| Receiver | Recent replay: 44 cache misses and failed YANG Library fetches; receiver validation is not established. |
| Producer | Recent bounded Kafka range: 1,000 eBNG records for 44 subscriptions, all with fallback schema ID 630. |
| Schema Registry | Schema ID 630 resolves as YANG; it is the collector's default schema, not evidence that the full device-specific schemas were obtained. |
| Blueplanet consumer | Latest comparable validation (Nov 12): 1,000 attempts, 130 consumed and 870 failed deserialization, all under schema ID 630. The Nov 13 re-read used serializer 0.0.5 rather than the deployed 0.0.6-shaded artifact and is not substituted. See the [per-subscription analysis](blueplanet-messagebroker-consumer/readme.md). |

### Issue

The replayed router content ID is `190100522`, but the active eBNG cache's
subscription records use `2300156437`. On cache misses, NetCalyx attempted to
fetch the YANG Library from `10.190.33.167:12345`; the connection was refused.
For subscription 217, the fetch failed after about 3 minutes 39 seconds, after
which the collector logged fallback to schema ID 630. This explains why Kafka
messages appeared after a delay. The separate Blueplanet consumer run recorded
130 successful deserializations and 870 failures under schema 630. The detailed
consumer report classifies the failures and distinguishes schema-closure gaps
from payload-data defects; receiver-side validation remains unestablished.

Obtain the correct eBNG NetCalyx receiver cache and subscription metadata from
the original device or NetCalyx team before relying on device-specific schema
validation. The supplied eBNG cache archive is identical to the ALIVE archive.

### Evidence

- [Publisher capture and earlier replay](netcalyx-yangpush-publisher/readme.md)
- [Producer Kafka results](netcalyx-messagebroker-producer/readme.md)
- [Receiver cache and collector logs](netcalyx-yangpush-receiver/readme.md)
- [Schema Registry response](yang-schema-registry/readme.md)
- [Blueplanet consumer evidence status](blueplanet-messagebroker-consumer/readme.md)
- [Machine-readable evidence summary](evidence-summary.json)
- [SHA-256 manifest](sha256.json)