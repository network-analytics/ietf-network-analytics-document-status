## Blueplanet Consumer Verification Status

**Latest run: 2026-11-10.** The Blueplanet Java consumer used JAR MD5
`60a14301979a3284cbdeb4ce4f6de9b5` and logged 1,180 records: **1,026 consumed,
154 failed**. All 27 `subscription-started` control messages failed parsing
because their `ietf-yang-push-revision:module-version` entries use `name`, while
the referenced Registry v2 schema requires `module-name`. For data updates,
1,026 passed and 127 failed.

### Results by Subscription

The table separates data updates from the one `subscription-started` control
message observed for each subscription. The 1,026 passed and 127 failed totals
below count push-update data only.

| ID | Push updates passed / failed | Subscription-started | Data-update result |
|---:|---:|---|---|
| 1 | 0 / 55 | 1 failed | Selected statistics omit mandatory `if:discontinuity-time`; `when` checks also depend on absent interface fields. |
| 2 | 0 / 6 | 1 failed | Selected statistics omit mandatory `if:discontinuity-time`. |
| 3 | 0 / 6 | 1 failed | Selected statistics omit mandatory `if:discontinuity-time`. |
| 4 | 0 / 6 | 1 failed | Selected statistics omit mandatory `if:discontinuity-time`. |
| 5 | 960 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 6 | 0 / 37 | 1 failed | `ethernetCsmacd-xcvr` does not satisfy the registered four-base `sub-class` identityref. |
| 7 | 0 / 0 | 1 failed | No push-update observed. |
| 8 | 0 / 7 | 1 failed | `pon-xcvr` does not satisfy the registered four-base `sub-class` identityref. |
| 9 | 0 / 0 | 1 failed | No push-update observed. |
| 10 | 0 / 6 | 1 failed | `ont-ani-xcvr` does not satisfy the registered four-base `sub-class` identityref. |
| 11 | 0 / 0 | 1 failed | No push-update observed. |
| 12 | 8 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 13 | 8 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 14 | 8 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 15 | 3 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 16 | 18 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 17 | 18 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 18 | 2 / 0 | 1 failed | All data updates passed filter-aware validation. |
| 19 | 0 / 2 | 1 failed | Missing mandatory interface port-reference and statistics data. |
| 20 | 0 / 0 | 1 failed | No push-update observed. |
| 21 | 0 / 1 | 1 failed | Missing mandatory interface port-reference and statistics data. |
| 22 | 0 / 0 | 1 failed | No push-update observed. |
| 23 | 1 / 0 | 1 failed | One data update passed. |
| 24 | 0 / 0 | 1 failed | No push-update observed. |
| 25 | 0 / 1 | 1 failed | Consumer rejected board `alarm-state`; the sample contains an empty bits value. |
| 26 | 0 / 0 | 1 failed | No push-update observed. |
| 27 | 0 / 0 | 1 failed | No push-update observed. |

The consumer log is `/bp2/data/consumer-validation.log` in the AWE `app`
container. It records payload JSON and deserialization errors, but does not
consistently print Kafka offsets for failed records. The run used the legacy
Schema Registry path; no YANG Library cache was configured. Mock-fixture
validation was not part of this replay.

### Failed Examples and Registry Evidence

The examples below are representative FANO messages retained in the Blueplanet
receiver evidence, not necessarily the exact records from the Java log. The
[Registry export](../yang-schema-registry/fano-confluent-schemaregistry-schema-content.tar.gz)
contains the referenced subject/version responses from `10.190.33.167:8081`.
The Java log remains on the AWE server and is not included in this folder.

- **Subscription-started, IDs 1-27:** The
	[ID 1 sample](../netcalyx-yangpush-receiver/yp-s001-subscription-started.json)
	has `"module-version": [{"name": "iana-if-type", ...}]`. Registry subject
	`netcalyx.labietf-yang-push-revision` version 2 defines
	`list module-version { key "module-name"; ... }` and a mandatory
	`leaf module-name`. The Java consumer reported a parsing failure for the
	`name` field. The neighboring NetCalyx environment's
	[sample](../../netcalyx/netcalyx-yangpush-receiver/yp-s001-subscription-started.json)
	uses `module-name`; it is a separate capture, not the Java replay payload.
- **Statistics, IDs 1-4:** The
	[ID 1 update](../netcalyx-yangpush-receiver/yp-s001-push-update.json)
	contains `statistics` counters without `discontinuity-time`. Registry
	`netcalyx.labietf-interfaces` version 2 defines
	`leaf discontinuity-time { type yang:date-and-time; mandatory true; }`.
	The Java validator reported the missing leaf. The receiver's successful
	validation is a separate observation; it does not establish that the Java
	replay and receiver applied identical validation rules to the same record.
- **Transceivers, IDs 6, 8 and 10:** The
	[ID 6 update](../netcalyx-yangpush-receiver/yp-s006-push-update.json)
	contains `huawei-hardware-types:ethernetCsmacd-xcvr`. Registry
	`netcalyx.labhuawei-hardware` version 1 gives `sub-class` four identityref
	bases, while `netcalyx.labhuawei-hardware-types` version 1 defines this
	identity with `base bbf-hwt:transceiver`. The consumer rejected these values;
	verify the effective model and identity ancestry before changing the payload.
- **Interfaces, IDs 19 and 21:** The consumer reported missing mandatory
	port-reference and statistics nodes. The
	[ID 19 update](../netcalyx-yangpush-receiver/yp-s019-push-update.json)
	shows interface entries without those fields. Determine whether the omitted
	nodes are required in the filtered update before assigning the cause.
- **Board state, ID 25:** The
	[sample](../netcalyx-yangpush-receiver/yp-s025-push-update.json) contains
	`"alarm-state": ""`. Registry `netcalyx.labietf-hardware` version 1 defines
	`alarm-state` as a `bits` type, not an enumeration. Under
	[RFC 7950 section 9.7.2](https://www.rfc-editor.org/rfc/rfc7950#section-9.7.2),
	the empty string represents no bits set. The consumer rejection therefore
	needs investigation against the effective schema and codec.

For example, retrieve the schema used for the control-message comparison:

```bash
curl -fsS http://10.190.33.167:8081/subjects/netcalyx.labietf-yang-push-revision/versions/2 \
	| jq -r '.schema' | grep -A7 'leaf module-name'
```

Selected schema text from the archived Registry responses:

```yang
// netcalyx.labietf-yang-push-revision, version 2
leaf module-name {
	type yang:yang-identifier;
	config false;
	mandatory true;
}

// netcalyx.labietf-interfaces, version 2
leaf discontinuity-time {
	type yang:date-and-time;
	mandatory true;
}

// netcalyx.labhuawei-hardware, version 1
type identityref {
	base bbf-hwt:transceiver;
	base bbf-hwt:transceiver-link;
	base ianahw:chassis;
	base ianahw:port;
}
```

The Registry's schema IDs 983, 985 and 993 are specific to this server; see the
[Registry evidence](../yang-schema-registry/readme.md) for all three responses.

### Blueplanet Connection and Deserialization Settings

| Setting | Value |
| --- | --- |
| bootstrap.servers | `10.190.33.167:9092` |
| Topic | `telemetry-yang` |
| schema.registry.url | `http://10.190.33.167:8081` |
| Kafka security protocol | `PLAINTEXT` |
| Key deserializer | `org.apache.kafka.common.serialization.StringDeserializer` |
| Value deserializer | `ch.swisscom.kafka.serializers.yang.json.KafkaYangJsonSchemaDeserializer` |

The remote consumer server must reach 9092/8081 and resolve the broker's
advertised name `onxv7308.ott.ciena.com`. Use the observed `schema-id` header;
do not infer it from a topic name. The Java deserializer JAR must be on the
consumer classpath. Its compatibility and validation results are not certified
by the kcat export.

### Reference NetCalyx Evidence Only

- [reference-netcalyx-consumer-fano-sample.log](reference-netcalyx-consumer-fano-sample.log):
	100 messages at offsets 1525-1624; **73 passed, 27 failed, zero context errors**.
- [reference-netcalyx-consumer-fano.log](reference-netcalyx-consumer-fano.log):
	single-message validation at offset 1525, which failed.
- [reference-netcalyx-consumer-cache-content.tar.gz](reference-netcalyx-consumer-cache-content.tar.gz):
	cached YANG module trees for schema IDs 983, 985, and 993.

The 27 failures concern `Node "name" not found as a child of "module-version"`
in captured subscription-started payloads. The reference consumer can return
exit code zero despite validation failures; inspect the summary.

Reference command on the lab server:

```bash
cd /home/bpadmin/netcalyx-migration
netcalyx-yang-consumer -b 10.190.33.167:9092 -g fano-reference-check \
	-t telemetry-yang -s http://127.0.0.1:8081 \
	--cache-root-path consumer-cache -o 1525 -l 100
```



[Producer samples](../netcalyx-messagebroker-producer/readme.md) and
[registry exports](../yang-schema-registry/readme.md) provide inputs for those checks.
Per-record processing exceptions and deserialization exceptions during `poll()`
are different; record their handling and any skipped offsets in Blueplanet logs.


