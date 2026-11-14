## YANG-Push Receiver - Message and YANG Schema Production

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netcalyx
grep 2001:db8:48::1 netcalyx-udpnotif-yangpush-right.log | grep 2026-09-18 | grep YangPushUpdate | grep validate | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
grep 2001:db8:48::1 netcalyx-udpnotif-yangpush-right.log | grep 2026-09-18 | grep YangPushChangeUpdate | grep validate | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 2001:db8:48::1 netcalyx-udpnotif-yangpush-right.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

your test results
```

### List Cache Directories - All Netconf Collected YANG Schemas per common YANG Schema Tree
```
cd /var/cache/netcalyx/yang_schemas
ll
```

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID 
```
your test results
```