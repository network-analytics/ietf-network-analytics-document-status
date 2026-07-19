## YANG Schema Registry - YANG Schema Collection

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
cd /var/log/netgauze
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'
```

```
your test results
```

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl https://schema-registry.sbd.corproot.net/schemas/ids/231594> schema_id_231594.json
curl https://schema-registry.sbd.corproot.net/schemas/ids/231595 > schema_id_231595.json
tar -czvf alive-confluent-schemaregistry-schema-content.tar.gz schema_id_231594.json schema_id_231595.json
```