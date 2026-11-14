## Titan NetCalyx YANG-Push Receiver Evidence

Nov 12 lab receiver: UDP `10.190.33.167:10000`; the active cache was Titan's
extracted cache. The capture source `10.215.217.123` was rewritten to peer
`10.190.33.167`.

### Cache Archives

- [Original Titan cache archive](titan-netcalyx-receiver-cache-content.tar.gz)
- [Active replay cache snapshot](titan-netcalyx-receiver-cache-content-repro-10.190.33.167.tar.gz)

The replay snapshot preserves the cache directory trees and records with
`peer_ip: 10.190.33.167`. Subscription cache trees include IDs 1-27 and 81-94.

### Captured Receiver Outcomes

[Titan receiver journal extract](titan-netcalyx-receiver-20261112.log) contains
**306 validation-drop log events** across these subscriptions:

| Subscription | Drops | Validation error |
| ---: | ---: | --- |
| 11 | 146 | OpenConfig interface `state`/`interface` nodes not found |
| 15 | 8 | OpenConfig LLDP `state` node not found |
| 19 | 6 | OpenConfig LACP `state` node not found |
| 21 | 22 | OpenConfig LACP `member` node not found |
| 23 | 8 | OpenConfig network-instance `adjacencies` node not found |
| 25 | 32 | OpenConfig network-instance `state` node not found |
| 27 | 48 | OpenConfig system `alarms` node not found |
| 83 | 10 | Cisco XR QoS statistics `policy-timestamp` missing from schema |
| 84 | 12 | Cisco XR QoS statistics `policy-timestamp` missing from schema |
| 94 | 14 | Invalid enumeration value `selection -point` |

These are logged validation-drop events, not a count of unique source messages or
a complete acceptance-rate denominator. The consumer results use a separate Java
replay and are documented in the [Blueplanet consumer README](../blueplanet-messagebroker-consumer/readme.md).

Inspect the active server cache and follow collector logs with:

```bash
readlink -f /var/cache/netcalyx/yang_schemas
find -L /var/cache/netcalyx/yang_schemas -name subscriptions-info.json
sudo -n journalctl -u netcalyx-collector -f
```