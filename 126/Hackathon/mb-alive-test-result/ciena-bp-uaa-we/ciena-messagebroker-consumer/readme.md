## YANG Message Broker Consumer - Message and YANG Schema Consumption

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /opt/netgauze-bin
RUST_LOG=kafka_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-sbd.json -s https://schema-registry.sbd.corproot.net --group daisy.dev.tg12345 -t daisy.dev.device-yang-raw -n 10 -f | grep 10.215.131.17 > /tmp/alive-netgauze-mb-consumer-log.txt
ll /opt/netgauze-bin/kafka-yang-consumer-cache
```

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d
3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae
56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178
de952a494c5e5a6b774852d5c1720c5269c94d4fdf9863f3cb3684fdb2ade057
eed2c01635cf828700187bb62284079f6b6fc6c5d95ab7b681a7c7bc952c81a1

tar -czvf alive-netgauze-mb-consumer-cache-content.tar.gz schema-id-1020 schema-id-1021 
```

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID 
```json
your test results
```

### Example Mockup Logs - Message and Validation State for Each Telemetry Message Validation Test Case
```json
your test results
```


