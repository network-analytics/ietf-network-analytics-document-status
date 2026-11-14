## BNS NetCalyx YANG-Push Receiver Evidence

Nov 11 lab receiver: `10.190.33.167:10000/UDP`. PCAP source:
`10.212.242.58`; replay and cache peer: `10.190.33.167`.

### Cache Archives

- [Original 6Wind BNS cache archive](6wind-bns-netcalyx-receiver-cache-content.tar.gz):
	preserved unchanged; subscription peer addresses identify the original device.
- [Active replay cache snapshot](6wind-bns-netcalyx-receiver-cache-content-repro-10.190.33.167.tar.gz):
	extracted BNS cache used for replay, with peer addresses rewritten to `10.190.33.167`.

The active cache has **14 subscription records** across five cache trees for
subscription IDs 100-106. `yang-library-content-id` in the Kafka payload metadata
is the router's value `964707179`; it differs from the cache directory hashes.

### Nov 11 Receiver Log

[bns-netcalyx-receiver-20261111.log](bns-netcalyx-receiver-20261111.log) is a
filtered collector journal extract. It contains two dropped UDP notifications:

```text
subscription_id=100: Invalid identityref "iana-if-type:softwareLoopback" value - unable to map prefix to YANG schema.
subscription_id=104: Invalid identityref "vrouter-alarm:service-alarm" value - unable to map prefix to YANG schema.
```

These are receiver-side YANG validation failures. The 60 packets sent by the
replayer are not equivalent to 60 validated notifications or Kafka messages.
Several other messages reached the producer path but could not be published
because Schema Registry rejected `vrouter-aaa` schema parsing; see the
[producer](../netcalyx-messagebroker-producer/readme.md) and
[Registry](../yang-schema-registry/readme.md) results.

### Inspect the Server Cache and Log

```bash
readlink -f /var/cache/netcalyx/yang_schemas
find -L /var/cache/netcalyx/yang_schemas -name subscriptions-info.json
sudo -n journalctl -u netcalyx-collector --since "2026-11-11 15:40:00" \
	--no-pager -o cat | grep -E "peer=10.190.33.167|Error sending message"
```