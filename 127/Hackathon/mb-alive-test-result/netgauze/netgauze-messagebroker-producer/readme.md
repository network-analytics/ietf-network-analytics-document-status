## YANG Message Broker Producer - Message and YANG Schema Production

The producer is part of the NetGauze 0.14 collector; its log lines are in `collector.log` of
`../netgauze-yangpush-receiver/alive-netgauze-receiver-log.tar.gz`, its configuration in
`../netgauze-yangpush-receiver/config-lab.yaml` (topic `telemetry-message-yang-alive`, registry
`http://localhost:8081`, subject prefix `lab`, root schema `ietf-telemetry-message`).

### Search Log - Produced Messages and YANG Schemas and Filter by YANG-Push Publisher IP Address
```bash
tar -xzf ../netgauze-yangpush-receiver/alive-netgauze-receiver-log.tar.gz
grep -c 'Message delivered successfully to kafka' collector.log   # 2089  messages delivered
grep -c 'using default schema ID' collector.log                   # 355   of them with the default schema id 36
grep -c 'registered schema' collector.log                         # 1795  module registrations, registry ids 1-628
grep ::1 collector.log | grep schemaID | awk -F'subscription_id=' '!seen[$2+0]++' | sed -E 's/^([^ ]+) +([A-Z]+) [^ ]+ (.*) peer=(.*) router_content_id.*(schema_id=[0-9]+) content_id="([0-9a-f]{8}).*/\1 \2 \3 peer=\4 \5 content_id="\6..."/'
```

```
2026-11-10T10:16:14.108733Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=5 schema_id=628 content_id="453f4d25..."
2026-11-10T10:16:14.109243Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=2 schema_id=628 content_id="453f4d25..."
2026-11-10T10:16:14.109660Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=16 schema_id=624 content_id="8c492dc8..."
2026-11-10T10:16:14.109712Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=18 schema_id=624 content_id="8c492dc8..."
2026-11-10T10:16:14.109769Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=4 schema_id=628 content_id="453f4d25..."
2026-11-10T10:16:14.109995Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=3 schema_id=628 content_id="453f4d25..."
2026-11-10T10:16:14.110514Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=1 schema_id=627 content_id="ba7855ef..."
2026-11-10T10:16:16.089827Z TRACE Found schemaID for the corresponding contentID peer=::1 subscription_id=17 schema_id=624 content_id="8c492dc8..."
```

Every notification the receiver validated (1,734) or forwarded without validation (355) is delivered: 2,089 messages.
The three device libraries are registered once each, between 10:15:57 and 10:16:14, while the replay is running.

### Summerize Log - By YANG-Push Subscription ID, YANG Schema ID and Cache Content ID
```bash
grep ::1 collector.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++' | sort -t '=' -k2 -n
grep ::1 collector.log | grep 'using default schema ID' | sed -E 's/.*(subscription_id=[0-9]+).*(default_schema_id=[0-9]+).*/\1 \2/' | sort -t '=' -k2 -n | uniq -c
```

```
subscription_id=1 schema_id=627 content_id="ba7855ef7d75b05e94a0fd703285230c48c90a4666e9da2742714866fbb5e285"
subscription_id=2 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=3 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=4 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=5 schema_id=628 content_id="453f4d25a4ebb5a8404c1121382e85d142acfe603df24b7957a1a6f8291adddb"
subscription_id=16 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=17 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"
subscription_id=18 schema_id=624 content_id="8c492dc81cb76c290fff23444916afc1acf5eedf892a484d77d4549feadb6ddd"

     82 subscription_id=7 default_schema_id=36
      3 subscription_id=13 default_schema_id=36
    247 subscription_id=14 default_schema_id=36
     23 subscription_id=19 default_schema_id=36
```

| Schema id    | Content id                    | Subscriptions (messages delivered)        | Messages |
|--------------|-------------------------------|-------------------------------------------|----------|
| 624          | `8c492dc8...`                 | 16 (82), 17 (2), 18 (82)                  | 166      |
| 627          | `ba7855ef...`                 | 1 (82)                                    | 82       |
| 628          | `453f4d25...`                 | 2 (82), 3 (324), 4 (81), 5 (999)          | 1,486    |
| 36 (default) | none (subscription not cached) | 7 (82), 13 (3), 14 (247), 19 (23)        | 355      |

At least one message is produced for 12 of 16 subscriptions. Nothing is produced for subscriptions 6, 11, 12 and
15: all their notifications are rejected by the receiver or are not decodable (receiver readme). Subscriptions 7, 13,
14 and 19 are not in the receiver cache, so the producer has no content id for them and uses the default schema id 36
(`ietf-telemetry-message` with the telemetry-message modules only): `No content ID provided and for subscription,
using default schema ID ... default_schema_id=36`, 355 times.

NetCalyx 0.4.0, run locally on the same inputs, delivers the same 2,089 messages with the same schema ids.

### Examples - Message and Validation State for Each YANG-Push Subscription ID
One notification per subscription and notification type, extracted from the messages consumed from Kafka
(`tools/extract-examples.py`), is stored in `../netgauze-yangpush-receiver/`:

| Schema id | Files                                                                                             |
|-----------|---------------------------------------------------------------------------------------------------|
| 627       | `yp-s001-push-update.json`                                                                        |
| 628       | `yp-s002-push-update.json`, `yp-s003-push-update.json`, `yp-s004-push-update.json`, `yp-s005-push-update.json` |
| 624       | `yp-s016-push-update.json`, `yp-s017-push-change-update.json`, `yp-s018-push-update.json`         |
| 36        | `yp-s007-subscription-started.json`, `yp-s007-push-update.json`, `yp-s013-subscription-started.json`, `yp-s013-push-update.json`, `yp-s014-subscription-started.json`, `yp-s014-push-update.json`, `yp-s019-subscription-started.json`, `yp-s019-push-change-update.json` |
