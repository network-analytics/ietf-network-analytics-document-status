## YANG Message Broker Consumer - Message and YANG Schema Consumption

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /opt/netcalyx-bin
RUST_LOG=netcalyx_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-sbd.json -s https://schema-registry.sbd.corproot.net --group daisy.dev. -t daisy.dev.device-yang-raw -n 10 -f | grep 10.215.134.62 > /tmp/ebng-netgauze-mb-consumer-log.txt
ll /opt/netcalyx-bin/kafka-yang-consumer-cache
```

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
ll /opt/netcalyx-bin/kafka-yang-consumer-cache/
total 0
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-235571
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-235572
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-235575
drwxr-xr-x  3 root root   72 Oct  9 13:55 schema-id-236414
drwxr-xr-x  3 root root   72 Oct  9 13:55 schema-id-236740
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-236749

tar -czvf ebng-netcalyx-mb-consumer-cache-content.tar.gz schema-id-235571 schema-id-235572 schema-id-235575 schema-id-236414 schema-id-236740 schema-id-236749
```

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID 
```json
see ebng-netgauze-mb-consumer-log.txt
```