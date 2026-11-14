## NetCalyx YANG-Push Receiver Evidence

Collected from `10.190.33.167` on 2026-11-06. Listener: UDP 10000.
The receiver configuration is [config-lab.yaml](config-lab.yaml); the dedicated
NETCONF key referenced by it is deliberately excluded from this repository.

### Cache and Notification Samples

[fano-netcalyx-receiver-cache-content.tar.gz](fano-netcalyx-receiver-cache-content.tar.gz)
contains the extracted server FANO cache, with `peer_ip: 10.190.33.167` in every
subscription record. [subscriptions.json](subscriptions.json) includes each
record's cache ID. The original source address in the PCAP is `10.80.32.79`.

Files named `yp-sNNN-<notification>.json` are envelope samples extracted from
retained, NetCalyx-produced Kafka messages, not direct PCAP-decoder output.
There are 50 subscription/type samples. An absent data-update sample must not
be interpreted as successful validation for that subscription.

### Receiver Logs

[fano-netcalyx-receiver.log](fano-netcalyx-receiver.log) contains journal lines
with the replay peer and subscription/schema IDs. It is a filtered export,
not a complete journal. INFO-level logging does not provide a complete list of
successful per-packet validations.

On the server:

```bash
readlink -f /var/cache/netcalyx/yang_schemas
find /home/bpadmin/netcalyx-migration/caches/fano -name subscriptions-info.json
sudo -n journalctl -u netcalyx-collector --no-pager -o cat | grep 'subscription_id='
```

All subscription IDs 1-27 appear in produced messages. Receiver logs show some
transceiver notifications rejected for invalid union/decimal64 encoding.
This does not establish one successfully validated data update for every ID.