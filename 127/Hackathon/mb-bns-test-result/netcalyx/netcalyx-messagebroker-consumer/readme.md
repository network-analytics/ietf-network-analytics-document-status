## YANG Message Broker Consumer - Message and YANG Schema Consumption

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /opt/netcalyx-bin
RUST_LOG=netcalyx_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-aws.json -s http://10.212.242.4:8080 --group daisy.ietf. -t daisy.ietf.device-yang-raw -n 10 -f | grep 10.212.242.58 > /tmp/6wind-bns-netgauze-mb-consumer-log.txt
ll /opt/netcalyx-bin/kafka-yang-consumer-cache
```

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
ll /opt/netcalyx-bin/kafka-yang-consumer-cache/
total 0
drwxr-xr-x  3 root root   72 Oct 22 13:58 schema-id-118828
drwxr-xr-x  3 root root   72 Oct 22 13:58 schema-id-118694
drwxr-xr-x  3 root root   72 Oct 22 13:58 schema-id-118695
drwxr-xr-x  3 root root   72 Oct 22 13:55 schema-id-118697

tar -czvf 6wind-bns-netcalyx-mb-consumer-cache-content.tar.gz schema-id-118828 schema-id-118694 schema-id-118695 schema-id-118697
```

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID 
```json
see 6wind-bns-netgauze-mb-consumer-log.txt
```