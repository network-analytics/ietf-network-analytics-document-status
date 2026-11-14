## BNS NetCalyx Message Broker Producer

Server: `10.190.33.167`; Kafka: `10.190.33.167:9092` (`PLAINTEXT`); topic:
`telemetry-yang`; Schema Registry: `http://10.190.33.167:8081` (`HTTP`).
Replay key: `10.190.33.167`; source device in the PCAP: `10.212.242.58`.

### Nov 11 Kafka Results

The full replay advanced partition 0 from offset **47781** to end offset
**47799**, producing **18 records** with schema headers. Observed records cover
subscriptions 100-104 only; cache subscriptions 105 and 106 had no records in
this replay.

| Subscription | Schema ID | YANG library content ID | Push updates | Subscription-started |
| ---: | ---: | --- | ---: | ---: |
| 100 | 1589 | `964707179` | 0 | 1 |
| 101 | 1589 | `964707179` | 6 | 1 |
| 102 | 1588 | `964707179` | 1 | 1 |
| 103 | 1588 | `964707179` | 6 | 1 |
| 104 | 1591 | `964707179` | 0 | 1 |

The YANG library content ID is carried in the Kafka payload metadata and is
distinct from the cache directory hashes.

The full breakdown is in [subscription-schema-summary.json](subscription-schema-summary.json).
The eight `tm-sNNN-*.json` files are representative Kafka records including
schema headers and payloads. The full Kafka-record archive is not retained.

### Producer and Receiver Errors

The receiver dropped two messages:

```text
subscription_id=100: Invalid identityref "iana-if-type:softwareLoopback" value - unable to map prefix to YANG schema.
subscription_id=104: Invalid identityref "vrouter-alarm:service-alarm" value - unable to map prefix to YANG schema.
```

Seven producer attempts failed because the Schema Registry YANG provider
returned HTTP 422 while parsing `vrouter-aaa`. The saved Registry extract does
not include the response body or a stack trace, so the underlying exception
cannot be independently verified from the retained evidence. See the
[receiver journal extract](../netcalyx-yangpush-receiver/bns-netcalyx-receiver-20261111.log)
and [Schema Registry extract](../yang-schema-registry/schema-registry-bns-20261111.log).

### Historical NetCalyx Results

The separate NetCalyx result folder records an earlier BNS run and different
Registry IDs (118694, 118695, 118697, 118707, 118828). Do not use those IDs for
the Nov 11 replay. The IDs observed here are **1588, 1589, and 1591**. Successful
retrieval of those schemas does not mean every attempted schema registration
succeeded.