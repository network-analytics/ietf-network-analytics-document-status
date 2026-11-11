## YANG Schema Registry - YANG Schema Collection

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
cd /var/log/netcalyx
grep 10.80.32.79 netcalyx-udpnotif-yangpush-right.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'
```

```
subscription_id=5 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=6 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=1 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=10 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=8 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=15 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=16 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=17 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=18 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=12 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=3 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=2 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=14 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=13 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=4 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=7 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=9 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=11 schema_id=236781 content_id="53af95641451c5b55472a760b3a8c3ef7f7654b1f054fa339059a6d53ad24061"
subscription_id=19 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=20 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=21 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=22 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=23 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=24 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=25 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=26 schema_id=236779 content_id="38ef21388d946bb1170266638d3b9df74ed43c70bafd04f8471f0cfe0648b482"
subscription_id=27 schema_id=236780 content_id="f0961ff3857c90ce887a98827636a4904aaec60b6b5e6109e74aadb703832521"
```

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl https://schema-registry.sbd.corproot.net/schemas/ids/236779 > schema_id_236779.json
curl https://schema-registry.sbd.corproot.net/schemas/ids/236780 > schema_id_236780.json
curl https://schema-registry.sbd.corproot.net/schemas/ids/236781 > schema_id_236781.json

tar -czvf fano-confluent-schemaregistry-schema-content.tar.gz schema_id_236779.json schema_id_236780.json schema_id_236781.json
```