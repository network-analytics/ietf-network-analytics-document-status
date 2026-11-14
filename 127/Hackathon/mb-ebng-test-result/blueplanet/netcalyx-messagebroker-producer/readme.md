## eBNG NetCalyx Message Broker Producer

Server `10.190.33.167`; broker `10.190.33.167:9092`; topic `telemetry-yang`;
partition 0. The captured device hostname is `ipt-lss923-a-mbi-05`.

### Kafka Evidence, 2026-11-12

The bounded offset range **50988-51987** contains **1,000 records** for this
hostname and 44 subscription IDs. All carry `schema-id=630` and
`content-type=application/yang.data+json`. Their collection timestamps span
16:43:59-16:45:26 UTC.

| Notification | Records |
| --- | ---: |
| `push-update` | 854 |
| `push-change-update` | 83 |
| `subscription-started` | 44 |
| `subscription-terminated` | 19 |

- [Per-subscription and notification breakdown](kafka-summary-20261112T164053Z.json)
- [Subscription 220 push-update at offset 51534](tm-s220-push-update-offset-51534.json)

The collector reported cache misses and used default schema ID 630 after YANG
Library fetch failures. These are produced Kafka records, not evidence of
successful receiver or Blueplanet validation. The range is an observed bounded
slice, not a count of all source packets or unique notifications.

To inspect the retained sample directly on the lab server:

```bash
kcat -C -b localhost:9092 -t telemetry-yang -p 0 -o 51534 -c 1 -e | jq .
```