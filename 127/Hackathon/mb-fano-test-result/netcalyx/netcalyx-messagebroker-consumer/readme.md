## YANG Message Broker Consumer - Message and YANG Schema Consumption

### Search Log - Consume Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
cd /opt/netcalyx-bin
RUST_LOG=netcalyx_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-sbd-stable.json -s https://schema-registry.sbd.corproot.net --group daisy.test. -t daisy.test.device-yang-raw -n 10 -f | grep 10.80.32.79 > /tmp/fano-netcalyx-mb-consumer-log.txt
ll /opt/netcalyx-bin/kafka-yang-consumer-cache
```

### List Cache Directories - All YANG Schema ID's being used for serialization
```bash
ll /opt/netcalyx-bin/kafka-yang-consumer-cache/
total 0
drwxr-xr-x  3 root root   72 Oct 20 16:52 schema-id-236779
drwxr-xr-x  3 root root   72 Oct 20 16:52 schema-id-236780
drwxr-xr-x  3 root root   72 Oct 20 16:52 schema-id-236781

tar -czvf fano-netcalyx-mb-consumer-cache-content.tar.gz schema-id-236779 schema-id-236780 schema-id-236781
```

### Example Logs - Message and Validation State for Each YANG-Push Subscription ID 
```json
see ebng-netcalyx-mb-consumer-log.txt
```