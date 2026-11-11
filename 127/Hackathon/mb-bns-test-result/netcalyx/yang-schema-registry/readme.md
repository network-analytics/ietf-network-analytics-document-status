## YANG Schema Registry - YANG Schema Collection

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
cd /var/log/netcalyx
grep 10.212.242.58 netcalyx-udpnotif-yangpush-*.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=104 schema_id=118828 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"
subscription_id=101 schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=100 schema_id=118695 content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86"
subscription_id=103 schema_id=118707 content_id="8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175"
subscription_id=101 schema_id=118695 content_id="2ec7d285fe71a9eb3ad9a958fa941906d5e37eb0cacc26988aecb80abd613a86"
subscription_id=102 schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=104 schema_id=118697 content_id="add0a8f1059c582885e01df79e854f768477c3515f684c0d1c43fb54b325c3ba"
subscription_id=103 schema_id=118694 content_id="6bd323768f1d05ab289405574402c0292f109bc1c31b1adab5f4aff4d05793b8"
subscription_id=105 schema_id=118707 content_id="8a2dd35e6faf18951a10d46385814f84a21a00ce8b180088529feb3e0066a175"
subscription_id=106 schema_id=118828 content_id="848fd359a89fd8ac6bd6341d3cd06cbede1b3ec0550e45c848c27475f12c908c"
```

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl http://10.212.242.4:8080/schemas/ids/118828 > schema_id_118828.json
curl http://10.212.242.4:8080/schemas/ids/118694 > schema_id_118694.json
curl http://10.212.242.4:8080/schemas/ids/118695 > schema_id_118695.json
curl http://10.212.242.4:8080/schemas/ids/118697 > schema_id_118697.json
tar -czvf 6wind-bns-confluent-schemaregistry-schema-content.tar.gz schema_id_118828.json schema_id_118694.json schema_id_118695.json schema_id_118697.json
```