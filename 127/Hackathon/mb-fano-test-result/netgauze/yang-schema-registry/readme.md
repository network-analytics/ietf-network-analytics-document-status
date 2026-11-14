## YANG Schema Registry - YANG Schema Collection

Confluent Schema Registry 7.8.0 with `yang-schema-registry-plugin-0.0.6-7.4-shaded.jar`
(`schema.providers = [ch.swisscom.kafka.schemaregistry.yang.YangSchemaProvider]`,
`SCHEMA_REGISTRY_OPTS=-Dyang.hotfix.skip-reference-parsing=true`, heap `-Xms18192M -Xmx52768M`, 16 MB record limit),
see `docker/docker-compose.kafka.yml`. The stack is recreated empty before the run, so schema ids start from 1.

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
grep 127.0.0.79 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
```
```
schema_id=391  content_id=38ef2138...  subscriptions 1-5, 12-26
schema_id=390  content_id=53af9564...  subscriptions 6-11
schema_id=399  content_id=f0961ff3...  subscription 27 (registration line, see ../netgauze-messagebroker-producer/readme.md)
```

### Curl - Obtain YANG Schemas from Schema Registry
Every schema id that appears in the collector or consumer log is fetched after the run (`tools/run-lab.sh`):
```bash
curl -sf http://localhost:8081/schemas/ids/390 > schema_id_390.json   # 22288 bytes, schemaType YANG, 129 references
curl -sf http://localhost:8081/schemas/ids/391 > schema_id_391.json   # 22206 bytes, schemaType YANG, 128 references
curl -sf http://localhost:8081/schemas/ids/399 > schema_id_399.json   # 22474 bytes, schemaType YANG, 131 references
tar -tzf fano-netgauze-confluent-schemaregistry-schema-content.tar.gz | grep -c schema_id_                # 366
```
`fano-netgauze-confluent-schemaregistry-schema-content.tar.gz` holds 366 `schema_id_N.json` files (ids between 1 and
399, all `schemaType: YANG`): the three root schemas above plus every module the consumer fetched as a reference. All
schemas were obtainable. The three root schemas are versions 4, 5 and 6 of subject `labietf-telemetry-message`
(`ietf-telemetry-message@2026-10-25`) and differ only in their references: 390 = 391 + `labhuawei-hardware-types`;
399 = 391 + `labhuawei-alarm-management`, `labhuawei-ietf-alarms-deviations`, `labhuawei-ietf-alarms-ext`.
