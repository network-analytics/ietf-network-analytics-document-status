## YANG Message Broker Consumer - Message and YANG Schema Consumption

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /opt/netcalyx-bin
RUST_LOG=netcalyx_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-sbd.json -s http://10.212.242.4:8080 --group daisy.dev. -t daisy.dev.device-yang-testing-raw -n 10 -f | grep 10.215.217.123 > /tmp/titan8k-netgauze-mb-consumer-log.txt
ll /opt/netcalyx-bin/kafka-yang-consumer-cache
```

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
ll /opt/netcalyx-bin/kafka-yang-consumer-cache/
total 0
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-119618
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-119660
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-119626
drwxr-xr-x  3 root root   72 Oct  9 13:55 schema-id-119633
drwxr-xr-x  3 root root   72 Oct  9 13:55 schema-id-119638
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-119636
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-119630
drwxr-xr-x  3 root root   72 Oct  9 13:55 schema-id-119653
drwxr-xr-x  3 root root   72 Oct  9 13:55 schema-id-119623
drwxr-xr-x  3 root root   72 Oct  9 13:58 schema-id-119657

tar -czvf titan-netcalyx-mb-consumer-cache-content.tar.gz schema-id-119618 schema-id-119660 schema-id-119626 schema-id-119633 schema-id-119638 schema-id-119636 schema-id-119630 schema-id-119653 schema-id-119623 schema-id-119657
```

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID 
```json
see titan-netgauze-mb-consumer-log.txt
```