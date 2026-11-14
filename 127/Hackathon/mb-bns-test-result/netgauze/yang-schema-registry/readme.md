## YANG Schema Registry - YANG Schema Collection

Confluent Platform 7.8.0 (zookeeper, kafka, schema-registry) in docker with yang-schema-registry-plugin 0.0.6-7.4,
see `../../../docker/docker-compose.kafka.yml`: registry heap `-Xms18192M -Xmx52768M`,
`SCHEMA_REGISTRY_OPTS=-Dyang.hotfix.skip-reference-parsing=true`, 16 MB record limits (`KAFKA_MESSAGE_MAX_BYTES`,
`KAFKA_REPLICA_FETCH_MAX_BYTES`, `SCHEMA_REGISTRY_KAFKASTORE_MAX_REQUEST_SIZE`,
`SCHEMA_REGISTRY_KAFKASTORE_MAX_PARTITION_FETCH_BYTES` = 16777216). The stack is recreated empty
(`docker compose down -v`) before the run, so the schema ids below are those of a fresh registry.

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
grep -c "registered schema" collector.log                             # 312 (188 distinct schema ids, 1..188)
grep -cE "Failed to register|status code 4[0-9][0-9]" collector.log   # 0
grep "registered schema ietf-telemetry-message " collector.log | sed -E 's/.*version `Some\(([0-9]+)\)` and ID `Some\(([0-9]+)\)`.*/version \1 id \2/' | sort -u
```
The producer (NetGauze 0.14, `subject_prefix: lab`) registers every module of a YANG library as subject
`lab<module-name>` and the `ietf-telemetry-message` root schema, which references them, as a new version of subject
`labietf-telemetry-message`. All registrations succeed without a retry: no 409 Conflict, no 422, the 6WIND
`vrouter-*` modules included (`labvrouter-extensions` id 69, `labvrouter-alarm` id 106, `labvrouter-aaa` id 118).

| Root schema id | Subject version | References | YANG library (content id)                  | Subscriptions |
|----------------|-----------------|------------|--------------------------------------------|---------------|
| 34, 36         | 1, 2            | 4 (id 34)  | collector default libraries (ids 1-36)     | none          |
| 62             | 3               | 13         | `2ec7d285...` (`ietf-interfaces`)          | 100, 101      |
| 64             | 4               | 14         | `add0a8f1...` (`ietf-alarms`)              | 104           |
| 67             | 5               | 14         | `6bd32376...` (`ietf-hardware`)            | 102, 103      |
| 188            | 6               | 87         | `848fd359...` (6WIND `vrouter-*`, 74 refs) | 106           |

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl -sf http://localhost:8081/schemas/ids/188 > schema_id_188.json     # for every schema id in the run's logs
tar -tzf bns-netgauze-confluent-schemaregistry-schema-content.tar.gz | grep -c schema_id_    # 164
```
`bns-netgauze-confluent-schemaregistry-schema-content.tar.gz` holds one `schema_id_N.json` (`schemaType` `YANG`,
`schema`, `references`, `metadata`) for each of the 164 schema ids the consumer fetched: the four root schemas 62, 64,
67, 188 and every module they reference, directly or through another module (ids 1, 4, 5, 6, 10, 14-18, 29, 34 and
37-188). The other 24 ids, all below 37, belong to the default libraries and are not referenced by a device library.
All four root schemas are `module ietf-telemetry-message`, revision 2026-10-25, with features
`data-collection-manifest` and `network-node-manifest`.

`ietf-inet-types` and `ietf-yang-types` resolve to ids 5 and 6 (`@2021-02-22`, `@2013-07-15`, registered with the
default libraries) for every device library, although the device libraries list both as `@2025-12-22` (import-only).
The consumer validates all 25 messages with them; NetCalyx 0.4.0 shows the same on its own registry.
