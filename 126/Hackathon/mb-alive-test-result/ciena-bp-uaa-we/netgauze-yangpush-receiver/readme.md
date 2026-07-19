## YANG-Push Receiver - Message and YANG Schema Production

### Search Log - Received Notifications and Filter by YANG-Push Publisher IP Address
```bash
cd /var/log/netgauze
grep 10.215.131.17 netgauze-udpnotif-yangpush-left.log | grep validated | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep 10.190.64.79 netgauze-udpnotif-yangpush-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

your test results

subscription_id=1 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"
subscription_id=2 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"
subscription_id=3 content_id="324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d"
subscription_id=4 content_id="de952a494c5e5a6b774852d5c1720c5269c94d4fdf9863f3cb3684fdb2ade057"
subscription_id=5 content_id="eed2c01635cf828700187bb62284079f6b6fc6c5d95ab7b681a7c7bc952c81a1"
subscription_id=6 content_id="3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae"
subscription_id=7 content_id="3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae"
subscription_id=8 content_id="56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178"
subscription_id=9 content_id="56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178"
```

### List Cache Directories - All Netconf Collected YANG Schemas per common YANG Schema Tree
```
cd /var/cache/netgauze/yang_schemas
ll
324ad7172c652c8c64e394d246b304158b122e8ffa6895f53c323dcb62a8600d
3973f4b443bc17bd96967ced6e58dbb114da925acf88fcb203b553c450f0eaae
56c139e2cfbd97ba80aeb7d2679bbe9b31fae0307df3e54fbc226e4c6eae0178
de952a494c5e5a6b774852d5c1720c5269c94d4fdf9863f3cb3684fdb2ade057
eed2c01635cf828700187bb62284079f6b6fc6c5d95ab7b681a7c7bc952c81a1
```

### Examples - Notifications and Validation State for Each YANG-Push Subscription ID 
```
your test results
```