## 7. YANG Schema Registry - YANG Schema Collection

The YANG Message Broker Producer is registering the YANG schemas before messages are being serialized. 

### 7.1 Curl - Obtain YANG Schema

With curl we can verify wherever the YANG schemas have been registered properly.

```
curl https://schema-registry-sc.olt.stage.sbd.corproot.net/schemas/ids/516
curl https://schema-registry-sc.olt.stage.sbd.corproot.net/schemas/ids/527
```