## 4. YANG Message Broker Consumer - YANG Schema Collection

With the consumption of YANG Network Telemetry messages the schema id at the top of the YANG schema tree is being learned. The YANG schema and YANG feature metadata with all their related YANG schemas and YANG feature metadatas are being obtained and cached locally.

### 4.1 Cisco Crosswork Ingestion Service Implementation

The Cisco Crosswork Ingestion Service learns the YANG schema id from the Confluent wire-format header of each consumed Kafka message (`byte[0]=0x00` magic, `byte[1-4]=schema_id`). For each schema id, all related YANG modules are fetched from the Confluent Schema Registry via `GET /schemas/ids/{schemaId}` and cached locally.

In `/opt/cisco/dg/cache/` for each YANG schema id a dedicated folder is dynamically created when the YANG Message Broker Consumer is consuming from the topic. The extracted YANG modules are saved as `{module-name}@{revision}.yang` files.

The resolved schema context is cached in-memory per schema id so that subsequent messages with the same schema id do not require additional Schema Registry lookups.

## 5. YANG Message Broker Consumer - YANG Schema Tree Generation

With the previously obtained YANG schemas a YANG schema tree is being generated for message schema validation.


### 5.1 Cisco Crosswork Ingestion Service Implementation

The YANG schema tree is generated using [yangkit](https://github.com/yang-central/yangkit) (v1.5.0):

1. **Register statement implementations** — `YangStatementImplRegister.registerImpl()` is called once (idempotent) to register all YANG statement types with the parser
2. **Parse YANG modules** — `YangYinParser.parse(yangResourceDir)` scans all `.yang` files in the cache directory and builds a `YangSchemaContext` — the complete in-memory schema tree containing all parsed modules, data nodes, typedefs, groupings, augmentations, and `sx:structure` (RFC 8791) definitions
3. **Validate the schema context** — `schemaContext.validate()` resolves cross-module references (imports, augmentations, deviations, `uses` grouping expansions)

The `YangSchemaContext` object serves as the schema tree for subsequent message validation. It supports both normal YANG data tree nodes and `sx:structure` definitions (e.g., `ietf-notification:notification`), which is essential for validating YANG-Push telemetry messages structured per the [draft-ietf-nmop-yang-message-broker-integration](https://datatracker.ietf.org/doc/html/draft-ietf-nmop-yang-message-broker-integration) envelope format.


## 6. YANG Message Broker Consumer - YANG Telemetry Message Schema Validation

With the previously generated YANG schema tree, YANG Telemetry Message schema validation is performed.


### 6.1 Cisco Crosswork Ingestion Service Implementation

Validation is performed using `YangDataDocumentJsonParser` from [yangkit](https://github.com/yang-central/yangkit), which implements RFC 7951 (JSON Encoding of Data Modeled with YANG). Both `push-update` (periodic) and `push-change-update` (on-change) message types are supported.

The validator checks:
- **RFC 7951 format compliance** — e.g., `int64`/`uint64` values must be quoted as strings
- **YANG type constraints** — type mismatches are rejected
- **Mandatory leaf enforcement** — missing mandatory leaves produce validation errors

Validation traverses the YANG schema tree hierarchically, starting from each top-level object and walking down through containers, lists, and leaves:

```
Validating field 'ietf-telemetry-message:message'...
   ✔ Found container: data-collection-manifest
   ✔ Found container: network-operator-metadata
   ✔ Found container: payload
   ✔ Found container: telemetry-message-metadata
   ✔ Field 'ietf-telemetry-message:message' is valid.
   ✔ JSON successfully validated against YANG schema
```

For `push-change-update` messages, yang-patch edit values are reconstructed from their XPath target paths and validated individually against the schema tree.

**Validation Result:**
- **Valid** → message is forwarded for downstream ingestion
- **Invalid** → message is dropped, counter incremented

Below an example of Kafka consumer validation output processing 76 YANG-Push messages with schema id 140:

```
$ make kafka-consumer-validate KAFKA_GROUP=scott-group
[2026-03-06 14:32:15] Starting YANG-validated consumer (group=scott-group, schema-id=140)
[2026-03-06 14:32:16] Downloaded 35 YANG modules for schema-id 140
[2026-03-06 14:32:16] Built YANG schema context: 35 modules loaded
...
[2026-03-06 14:32:18] === Validation Summary ===
[2026-03-06 14:32:18] Total messages:   76
[2026-03-06 14:32:18] Valid messages:    76
[2026-03-06 14:32:18] Invalid messages:  0
[2026-03-06 14:32:18] Dropped messages:  0
```


### 6.2 Impediments

The upstream [yangkit](https://github.com/yang-central/yangkit) (v1.5.0) `YangDataDocumentJsonParser` did not support `sx:structure` (RFC 8791) definitions. JSON documents rooted at an `sx:structure` node (e.g., `ietf-notification:notification`) could not be parsed — the parser returned `null` because it only searched the normal YANG data tree.

A fix was contributed via [PR #41](https://github.com/yang-central/yangkit/pull/41), which adds a fallback BFS lookup in `YangDataUtil.getSchemaNodeContainerForDocument()` to search `sx:structure` definitions when the normal tree lookup fails. This fix is required for validating YANG-Push telemetry messages that use the `ietf-notification` envelope defined as `sx:structure notification` in [draft-ahuang-netconf-notif-yang](https://datatracker.ietf.org/doc/html/draft-ahuang-netconf-notif-yang).