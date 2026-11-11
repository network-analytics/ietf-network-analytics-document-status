## YANG Schema Registry - YANG Schema Collection

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
cd /var/log/netcalyx
grep 10.215.134.62 netcalyx-udpnotif-yangpush-*.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

```
subscription_id=5 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=1 schema_id=1240 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=2 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=16 schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=18 schema_id=1236 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=4 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=3 schema_id=1237 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
```

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl http://10.212.242.4:8080 > schema_id_1236.json
curl http://10.212.242.4:8080 > schema_id_1237.json
curl http://10.212.242.4:8080  > schema_id_1240.json
tar -czvf alive-confluent-schemaregistry-schema-content.tar.gz schema_id_1236.json schema_id_1237.json schema_id_1240.json
```