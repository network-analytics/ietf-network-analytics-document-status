## YANG Schema Registry - YANG Schema Collection

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
cd /var/log/netgauze
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'
```

```
subscription_id=8 schema_id=232713 content_id="8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef"
subscription_id=7 schema_id=232713 content_id="8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a"
subscription_id=1 schema_id=232714 content_id="5c2ff36ed86e12872239b3e2de7589c5a65892810accb4aa52f2ca4ddd3945c2"
subscription_id=9 schema_id=232713 content_id="8c3ebdaf4c8861b4abf859958accba883e1ef8ab434d5e824782cdf566e618ef"
subscription_id=4 schema_id=232713 content_id="291445b819ce7f2a60c90c69edae25a3893c475424e041fc663726bc8d5c7700"
subscription_id=6 schema_id=232713 content_id="8500c52c3d2e7ae4102fd2ccebf0230c7eac67d1ac4e0ac731645220f55ecd1a"
subscription_id=5 schema_id=232713 content_id="6edae3b4e0ec080847d3b7d6ea38aed212c70747a34ed5b2c0a2269d29509992"
```

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl https://schema-registry.sbd.corproot.net/schemas/ids/232713> schema_id_232713.json
curl https://schema-registry.sbd.corproot.net/schemas/ids/232714 > schema_id_232714.json
tar -czvf alive-confluent-schemaregistry-schema-content.tar.gz schema_id_232713.json schema_id_232714.json
```