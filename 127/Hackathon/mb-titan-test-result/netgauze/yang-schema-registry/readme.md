## YANG Schema Registry - YANG Schema Collection

Confluent Platform 7.8.0 (zookeeper, kafka, schema-registry) in docker with
`yang-schema-registry-plugin-0.0.6-7.4-shaded.jar`, heap `-Xms18192M -Xmx52768M`,
`SCHEMA_REGISTRY_OPTS=-Dyang.hotfix.skip-reference-parsing=true`, record limit 16 MB (`KAFKA_MESSAGE_MAX_BYTES`,
`KAFKA_REPLICA_FETCH_MAX_BYTES`, `SCHEMA_REGISTRY_KAFKASTORE_MAX_REQUEST_SIZE`,
`SCHEMA_REGISTRY_KAFKASTORE_MAX_PARTITION_FETCH_BYTES` = 16777216), see `docker/docker-compose.kafka.yml`. The stack is
recreated empty before the run, so schema ids start at 1. Producer log: `collector.log` in
`../netgauze-yangpush-receiver/titan-netgauze-receiver-log.tar.gz`.

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
grep 'registered schema' collector.log | sed -E 's/.*ID `Some\(([0-9]+)\)`.*/\1/' | sort -un | wc -l              # 311 (ids 1-311)
grep 'registered schema' collector.log | sed -E 's/.*subject `Some\("([^"]+)"\)`.*/\1/' | sort -u | wc -l          # 278 subjects
grep 'registered schema ietf-telemetry-message ' collector.log | sed -E 's/.*version `Some\(([0-9]+)\)` and ID `Some\(([0-9]+)\)`/\1:\2/' | sort -un
grep -c 'Failed to register' collector.log; grep -c 'status code' collector.log                                  # 0, 0
```
Subject `labietf-telemetry-message` has 13 versions; versions 3-13 are the 11 device libraries used by the messages:

| Version | Schema id | Content id | Subscriptions | Direct references |
|--------:|----------:|------------|---------------|------------------:|
| 3  | 79  | `369536a4...` | 82 | 25 |
| 4  | 82  | `8a199e95...` | 85 | 25 |
| 5  | 85  | `ca94d36b...` | 81 | 25 |
| 6  | 89  | `9b24ab29...` | 86 | 25 |
| 7  | 101 | `1c5665b1...` | 88 | 29 |
| 8  | 103 | `0367a6db...` | 83, 84 | 25 |
| 9  | 106 | `da952479...` | 87 | 25 |
| 10 | 111 | `801df0c5...` | 89-93 | 25 |
| 11 | 115 | `7d667a00...` | 94 | 25 |
| 12 | 308 | `4cf30b83...` | 1-6, 11-16, 23, 25, 27 | 86 |
| 13 | 311 | `c54630fc...` | 17-22 | 87 |

Versions 1 and 2 (ids 34, 36) are registered at collector start, before the replay, and no message uses them.

Every registration succeeded: no 409, no 422, no `Failed to register` in the producer log, and the registry answered
HTTP 200 to all requests of the run. This includes the two 1.3 MB modules of libraries `4cf30b83...` and `c54630fc...`,
which need the 16 MB record limit (the registry stores each schema as one record):

| Module | Size (bytes) | Schema id |
|--------|-------------:|----------:|
| `Cisco-IOS-XR-openconfig-platform-pipeline-counters-q200-ext@2024-08-20` | 1,334,408 | 272 |
| `Cisco-IOS-XR-openconfig-platform-pipeline-counters-p100-ext@2024-08-20` | 1,335,864 | 273 |

### Curl - Obtain YANG Schemas from Schema Registry
Every schema id that appears in the producer or consumer log is saved while the registry of the run is still up
(`tools/run-lab.sh`):
```bash
for id in <ids>; do curl -sf http://localhost:8081/schemas/ids/$id > schema_id_$id.json; done
tar -tzf titan-netgauze-confluent-schemaregistry-schema-content.tar.gz | grep -c 'schema_id_[0-9]*\.json'    # 288
```
`titan-netgauze-confluent-schemaregistry-schema-content.tar.gz` holds 288 `schema_id_N.json`: the 11 root schemas
above (`schemaType: YANG`, `module ietf-telemetry-message`, about 11.4 kB each, 18.5 kB for 308 and 311) and the 277
module schemas they reference, i.e. everything the consumer fetched. All 288 were obtainable.
