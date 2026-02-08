## 3. YANG Message Broker Publisher - YANG Schema Registration

Based on previously collected YANG modules and YANG library context, YANG schemas are registered with YANG feature metadata in YANG Schema registry according to https://datatracker.ietf.org/doc/html/draft-ietf-nmop-yang-message-broker-integration-10#section-4.4. YANG schema registry issues for each YANG module a Message Broker a unique schema id. The schema id at the top of the YANG schema tree is used as schema id in the message metadata at the YANG message producer when the Network Telemetry Message is being serialized.


### 3.1 NetGauze Implementation

In `/var/log/NetGauze/` `NetGauze-udpnotif-yangpush-left.log` shows for each YANG library cache contend-id which YANG schema id was being generated. See below an example for YANG library cache contend-id `06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827` and YANG Schema id `516`.

```
[root@ietf-col-left01 NetGauze]# tail -f NetGauze-udpnotif-yangpush-left.log | grep -e 06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827 | grep -e schemaID
2026-02-03T09:27:00.056244Z TRACE NetGauze_collector::publishers::kafka_yang: Found schemaID 516 for contentID 06bb7b0eac2786553a446740ed61659405d4e6d5fb4242f306234ee472c85827
```