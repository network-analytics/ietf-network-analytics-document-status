## NetCalyx Message Broker Producer Evidence

Server: `10.190.33.167`; Kafka: `10.190.33.167:9092` (`PLAINTEXT`); topic:
`telemetry-yang`, partition 0; Schema Registry: `http://10.190.33.167:8081`
(`HTTP`). The producer is NetCalyx 0.3.0 with writer ID
`lab-netcalyx-yang` and source device `ipd-zbl1536-s-ah-79`.

The retained Kafka collection was analyzed on 2026-11-06. It contains **11,452
records at offsets 1525-12976**. These are multiple replay runs plus one
manually republished subscription-5 record, not 11,452 unique source
notifications or a single complete PCAP run.

### Artifacts

- [subscription-schema-summary.json](subscription-schema-summary.json): message
	counts by subscription ID, schema ID, and notification type.
- [Subscription 5 push-update example](tm-s005-push-update.json).
- [Subscription 5 subscription-started example](tm-s005-subscription-started.json).
- `tm-sNNN-<notification>.json`: 50 first-observed Kafka record examples.

The full Kafka-record archive is intentionally not retained. The examples
preserve the Kafka envelope, key, payload, and schema headers for their sampled
records.

### Per-Subscription Schema and Cache Mapping

All 27 subscription IDs occurred in the collected messages. Each record has
`schema-id` and `content-type=application/yang.data+json` headers.

Cache content IDs are taken from the receiver cache-hit lines; schema IDs and
counts are derived from the retained Kafka records.

| Subscription | Schema ID | Cache content ID | Push updates | Subscription-started |
| ---: | ---: | --- | ---: | ---: |
| 1 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 518 | 4 |
| 2 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 62 | 4 |
| 3 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 64 | 4 |
| 4 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 62 | 4 |
| 5 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 9,529 | 4 |
| 6 | 985 | `53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061` | 347 | 4 |
| 7 | 985 | `53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061` | 0 | 4 |
| 8 | 985 | `53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061` | 67 | 4 |
| 9 | 985 | `53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061` | 0 | 4 |
| 10 | 985 | `53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061` | 64 | 4 |
| 11 | 985 | `53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061` | 0 | 4 |
| 12 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 70 | 4 |
| 13 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 68 | 4 |
| 14 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 69 | 4 |
| 15 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 32 | 4 |
| 16 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 169 | 4 |
| 17 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 169 | 4 |
| 18 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 29 | 4 |
| 19 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 8 | 4 |
| 20 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 2 | 4 |
| 21 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 4 | 4 |
| 22 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 1 | 4 |
| 23 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 4 | 4 |
| 24 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 1 | 4 |
| 25 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 4 | 4 |
| 26 | 983 | `38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482` | 1 | 4 |
| 27 | 993 | `f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521` | 0 | 4 |

To print the retained schema/message-count summary:

```bash
jq -r '.[] | "subscription_id=\(.subscription_id) schema_id=\(.schema_id) notification=\(.notification) messages=\(.messages)"' \
	subscription-schema-summary.json
```

Example retained producer record: subscription 5 push-update, partition 0,
offset 1567, key `10.190.33.167`, schema ID 983, and cache content ID
`38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482`. See
[tm-s005-push-update.json](tm-s005-push-update.json) for its full payload and
headers.

Per-subscription counts are in
[subscription-schema-summary.json](subscription-schema-summary.json). The
observed schema IDs and all referenced YANG schemas are documented in the
[Schema Registry results](../yang-schema-registry/readme.md). IDs are specific
to this server; do not use the historical `236779`-series IDs from the
neighboring NetCalyx test environment.

Subscription-started records count as produced records; they do not prove a
push-update was validated. See the [Blueplanet consumer results](../blueplanet-messagebroker-consumer/readme.md)
for the separate Nov 10 Java consumer results and per-subscription validation.

### Read Existing or New Messages

```bash
kcat -C -b 10.190.33.167:9092 -t telemetry-yang -o -1 -c 1 -f 'headers=%h\n%s\n'
kcat -C -b 10.190.33.167:9092 -t telemetry-yang -o end -f 'headers=%h\n%s\n'
```

The second command waits for new records. Reading messages with kcat is not
YANG-schema validation. To compare offsets before and after a replay:

```bash
/opt/kafka/bin/kafka-get-offsets.sh --bootstrap-server localhost:9092 \
	--topic telemetry-yang --time -1
```

The replay producer settings are shown in the
[publisher replay README](../netcalyx-yangpush-publisher/readme.md); the
collector and YANG cache settings are in the
[receiver README](../netcalyx-yangpush-receiver/readme.md).

The saved `fano-netcalyx-receiver.log` contains cache-hit and receiver
validation lines; it is not a producer `Found schemaID` trace. Schema IDs above
are taken from the Kafka message headers and summary artifact.

Reproduce the per-subscription cache content IDs from those receiver cache-hit
lines:

```bash
grep 'peer_ip=10.190.33.167' ../netcalyx-yangpush-receiver/fano-netcalyx-receiver.log \
	| grep 'cache hit:' \
	| sed -E 's/.*subscription_id=([0-9]+).*cached_content_id="([^"]+)".*/subscription_id=\1 content_id="\2"/' \
	| awk '!seen[$0]++'
```