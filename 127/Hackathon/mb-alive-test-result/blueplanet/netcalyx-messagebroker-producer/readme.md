## ALIVE NetCalyx Message Broker Producer

Server: `10.190.33.167`; Kafka: `10.190.33.167:9092` (`PLAINTEXT`); topic:
`telemetry-yang`; Schema Registry: `http://10.190.33.167:8081` (`HTTP`).
Publisher source from the PCAP: `2001:db8:48::1`; replay peer configured for the
receiver cache: `10.190.33.167`.

### Historical NetCalyx Producer Schema Lookups

The saved Sept 18 NetCalyx producer evidence records these subscription-to-schema
mappings. IDs 236779/236780/236781 in the FANO result folder belong to a different
environment and must not be used here.

| Subscription ID(s) | Schema ID | Cache content ID |
| --- | ---: | --- |
| 1 | 1240 | `ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285` |
| 2, 3, 4, 5 | 1237 | `453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb` |
| 16, 17, 18 | 1236 | `8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd` |
| 6-15, 19-27 | Not present in saved producer schema-lookup evidence | Not recorded |

Schema lookups are not message counts. The historical producer log has no
complete offset/count export, and the Blueplanet folder contains no saved Kafka
payload samples for this ALIVE run. Do not infer a message or validation count
from a `Found schemaID` line.

### Reproduce the Historical Log Search

On the NetCalyx host that has the Sept 18 log:

```bash
cd /var/log/netcalyx
grep '2001:db8:48::1' netcalyx-udpnotif-yangpush-right.log \
	| grep 'schemaID' | grep 'subscription_id='
```

Summarize distinct schema lookups by subscription and cache content ID:

```bash
grep '2001:db8:48::1' /var/log/netcalyx/netcalyx-udpnotif-yangpush-right.log \
	| grep 'schemaID' \
	| sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' \
	| awk '!seen[$0]++'
```

### Nov 10 Lab Replay and Producer Status

The first bounded replay reached NetCalyx, but Schema Registry temporarily
returned HTTP 500 while its Kafka-based leader was unknown:

```text
Error sending message to Kafka: YANG Library Schema Construction Error:
Schema registration error: status code 500 Internal Server Error
RestUnknownLeaderException: Leader not known.
```

After Schema Registry was restarted, its API reported `READWRITE` and a
registration request succeeded. However, the subsequent bounded replay did not
produce a confirmed Kafka record: the last run sent only two UDP packets, exited
with status 137, and the `telemetry-yang` end offset remained **39419**.

The receiver also dropped ALIVE notifications, including:

```text
subscription_id=6: Invalid identityref "iana-if-type:ethernetCsmacd" value - unable to map prefix to YANG schema.
subscription_id=12: Invalid identityref "iana-if-type:ppp" value - unable to map prefix to YANG schema.
subscription_id=13: Invalid identityref "iana-hardware:port" value - unable to map prefix to YANG schema.
subscription_id=14: Invalid identityref "iana-hardware:chassis" value - unable to map prefix to YANG schema.
subscription_id=11: Node "interface" not found in the "ietf-yang-push" module.
subscription-started: Node "datastore" not found as a child of "subscription-started" node.
```

The restored ALIVE cache lacks `iana-if-type@2014-05-08.yang` and does not list
`iana-if-type` beside `ietf-interfaces` in its YANG Library module set. The
NetCalyx team should supply a complete compatible cache/YANG Library; do not
manually inject or register the module. The downloaded archive is unchanged, and
the experimental extracted cache is not active.

**Conclusion:** Nov 10 ALIVE Kafka production is not verified. See the
[publisher replay notes](../netcalyx-yangpush-publisher/readme.md),
[receiver results](../netcalyx-yangpush-receiver/readme.md), and
[Registry results](../yang-schema-registry/readme.md). Blueplanet consumer
validation needs its own consumer logs and has not been established by the
historical NetCalyx producer traces.