## YANG Schema Registry - YANG Schema Collection

Confluent Platform 7.8.0 schema registry with yang-schema-registry-plugin 0.0.6-7.4
(`../../../docker/docker-compose.kafka.yml`), started empty for this run, so the ids below start from 1. The schemas
are registered by the NetGauze 0.14 producer under the subject prefix `lab`.

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
tar -xzf ../netgauze-yangpush-receiver/alive-netgauze-receiver-log.tar.gz
grep ::1 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
grep 'registered schema ietf-telemetry-message ' collector.log | sed -E 's/^([^ ]+) .*(version `Some\([0-9]+\)`) and (ID `Some\([0-9]+\)`)/\1 \2 \3/' | awk '!seen[$3 $4]++'
```

```
subscription_id=1 schema_id=627 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=2 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=3 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=4 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=5 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=16 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=17 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=18 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

2026-11-10T10:15:52.124040Z version `Some(1)` ID `Some(34)`
2026-11-10T10:15:52.175109Z version `Some(2)` ID `Some(36)`
2026-11-10T10:15:59.297722Z version `Some(3)` ID `Some(119)`
2026-11-10T10:16:09.690830Z version `Some(4)` ID `Some(624)`
2026-11-10T10:16:13.978024Z version `Some(5)` ID `Some(627)`
2026-11-10T10:16:14.108264Z version `Some(6)` ID `Some(628)`
```

Schema ids carried in the Kafka message headers (all `ietf-telemetry-message@2026-10-25`, subject
`labietf-telemetry-message`, schema type YANG):

| Schema id | Subject version | References | Receiver content id                     | Subscriptions          |
|-----------|-----------------|------------|-----------------------------------------|------------------------|
| 36        | 2               | 11         | none: default schema, no device modules | 7, 13, 14, 19          |
| 624       | 4               | 287        | `8c492dc8...`                           | 16, 17, 18 (15: no message) |
| 627       | 5               | 285        | `ba7855ef...`                           | 1                      |
| 628       | 6               | 284        | `453f4d25...`                           | 2, 3, 4, 5 (6, 11, 12: no message) |

The producer logs 1,795 `registered schema` lines for 628 distinct registry ids (one per YANG module revision plus
the `ietf-telemetry-message` versions); the registrations end at 10:16:14, 22 s after the replay started.
No device schema exists for subscriptions 7, 13, 14 and 19: their YANG libraries are not in the receiver cache
(`../netgauze-yangpush-receiver/readme.md`), so their messages refer to the default schema id 36.

### Curl - Obtain YANG Schemas from Schema Registry
`tools/run-lab.sh` dumps every schema id that appears in the collector and consumer logs (ids 1-628) after the
consumer has finished; all 628 are obtainable (628 files, all `schemaType` YANG with a non-empty `schema`):

```bash
for id in $(seq 1 628); do curl -sf http://localhost:8081/schemas/ids/$id > schema_id_$id.json; done
tar -czf alive-netgauze-confluent-schemaregistry-schema-content.tar.gz schema_id_*.json
tar -tzf alive-netgauze-confluent-schemaregistry-schema-content.tar.gz | grep -c 'schema_id_'   # 628
```

The consumer fetches schema ids 36, 624, 627 and 628 with all their references and builds a YANG context from each
(`../netgauze-messagebroker-consumer/readme.md`).
