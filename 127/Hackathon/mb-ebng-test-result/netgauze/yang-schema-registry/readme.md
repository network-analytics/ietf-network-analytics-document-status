## YANG Schema Registry - YANG Schema Collection

Confluent Schema Registry 7.8.0 in docker with `yang-schema-registry-plugin-0.0.6-7.4-shaded.jar`
(`ch.swisscom.kafka.schemaregistry.yang.YangSchemaProvider`), heap `-Xms18192M -Xmx52768M`,
`SCHEMA_REGISTRY_OPTS=-Dyang.hotfix.skip-reference-parsing=true`, 16 MB record limit, see
`docker/docker-compose.kafka.yml`. The stack is recreated empty before the run, so the schema ids start at 1:
the run registered ids 1-638 (one per YANG module, plus the versions of `labietf-telemetry-message`), every request
answered with HTTP 200.

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
grep 127.0.0.62 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
grep 'registered schema ietf-telemetry-message with subject' collector.log
```
```
schema_id=616  content_id=453f4d25...  subscriptions 1-4, 101, 200-205, 208-220, 301-304, 400-403
schema_id=625  content_id=8c492dc8...  subscriptions 104, 105, 106, 405
schema_id=628  content_id=afbee089...  subscriptions 206, 207
schema_id=631  content_id=ba7855ef...  subscriptions 300, 306
schema_id=634  content_id=3f7191b4...  subscription 100
schema_id=638  content_id=83e6ed2e...  subscriptions 102, 305, 404
```
All six are versions 4-9 of subject `labietf-telemetry-message` (module `ietf-telemetry-message@2026-10-25`) and
differ in the NE8000 modules they reference. Ids 34, 36 and 78 (versions 1-3) are the telemetry-message schema without
a device library; no message uses them.

### Curl - Obtain YANG Schemas from Schema Registry
Every schema id that appears in the producer or consumer log is fetched while the registry of the run is still up
(`tools/run-lab.sh`) and packaged by `tools/package-results.sh`:
```bash
curl -sf http://localhost:8081/schemas/ids/616 > schema_id_616.json   # 39446 bytes, schemaType YANG, 284 references
curl -sf http://localhost:8081/schemas/ids/625 > schema_id_625.json   # 39844 bytes, 287 references
curl -sf http://localhost:8081/schemas/ids/628 > schema_id_628.json   # 39582 bytes, 285 references
curl -sf http://localhost:8081/schemas/ids/631 > schema_id_631.json   # 39554 bytes, 285 references
curl -sf http://localhost:8081/schemas/ids/634 > schema_id_634.json   # 39566 bytes, 285 references
curl -sf http://localhost:8081/schemas/ids/638 > schema_id_638.json   # 39570 bytes, 285 references
...                                                                   # and each module schema the consumer fetched
tar -tzf ebng-netgauze-confluent-schemaregistry-schema-content.tar.gz | grep -c schema_id_           # 605
```
`ebng-netgauze-confluent-schemaregistry-schema-content.tar.gz` holds 605 `schema_id_N.json` (ids 1, 5, 6, 37-638, all
`schemaType` YANG): the six root schemas above and the 599 schemas the consumer fetched through their references. The
consumer obtained all 605 (`Fetched schema ID`, see the consumer readme); the resulting module sets are in
`../netgauze-messagebroker-consumer/ebng-netgauze-mb-consumer-cache-content.tar.gz`.
