## FANO YANG-Push Publisher Replay

### Capture and Address Mapping

| Item | Value |
| --- | --- |
| PCAP | `ipd-zbl1536-s-ah-79-yp-udpnotif-20261020-1651.pcap` |
| Original source | `10.80.32.79` |
| Replay source (`repro_ip`) | `10.190.33.167` |
| Captured UDP destination port | `10100` |
| NetCalyx destination | `10.190.33.167:10000/UDP` |
| Replay speed | 10x (`time_factor: 0.1`) |

The capture contains 45,148 UDP packets over about 6,593 seconds (110 minutes).
At 10x, a complete replay takes about 11 minutes, plus processing overhead.
The original PCAP and three NETCONF XML files in this folder are unchanged.

### Replay Configuration

The server-side YAML is `/home/bpadmin/netcalyx-migration/repro-fano.yaml`.
Its relevant settings are:

```yaml
pcap:
  - /home/bpadmin/netcalyx-migration/downloads/ipd-zbl1536-s-ah-79-yp-udpnotif-20261020-1651.pcap
time_factor: 0.1
keep_open: false
no_sync: true
optimize:
  threading: false
  preload: false
network:
  map:
    - src_ip: 10.80.32.79
      repro_ip: 10.190.33.167
  interface: null
udp_generic:
  select:
    udp:
      dport: [10100]
  collector:
    ip: 10.190.33.167
    port: 10000
```

Keep `src_ip` as the original PCAP address; it selects packets to rewrite.
`repro_ip` is the address the collector sees, matching the FANO cache's
`peer_ip`. The installed replay configuration has additional YAML formatting
and is authoritative if this excerpt is ever changed.

### Replay Commands

Kafka, Schema Registry, and the NetCalyx service must be healthy first. The
replay wrapper switches to the FANO cache and restarts NetCalyx; it does not
start Kafka or Schema Registry. Run one replay at a time:

```bash
ssh bpadmin@10.190.33.167
cd /home/bpadmin/netcalyx-migration
bash run-replay.sh fano 120
```

Use duration `0` for the whole capture:

```bash
bash run-replay.sh fano 0
```

Start a Kafka reader in a second SSH session before replay if you want to observe
new messages:

```bash
kcat -C -b 10.190.33.167:9092 -t telemetry-yang -o end \
	-f 'headers=%h\n%s\n'
```

Duration `0` has no automatic stop. The traffic-reproducer has a custom Ctrl+C
handler; if it does not stop, find the exact replay Python PID with `ps` and
send `sudo -n kill -TERM PID`. Do not kill Kafka or NetCalyx. A bounded replay
normally returns timeout status `124`; if the reproducer does not exit within the
wrapper's 10-second shutdown grace period, it may return `137` instead.

### Saved Evidence and Limits

- [Original FANO PCAP](ipd-zbl1536-s-ah-79-yp-udpnotif-20261020-1651.pcap)
- [Saved bounded replay log](replay-fano.log): a 120-second run sent 7,276 UDP packets.
- [FANO NETCONF capabilities](ipd-zbl1536-s-ah-79-netconf-systems-capa-20261020-1602.xml)
- [FANO NETCONF YANG Library](ipd-zbl1536-s-ah-79-netconf-yang-library-20261020-1602.xml)
- [FANO NETCONF subscriptions](ipd-zbl1536-s-ah-79-netconf-yp-subscription-20261020-1602.xml)

The saved bounded log and the Kafka collection summarized in the
[producer results](../netcalyx-messagebroker-producer/readme.md) are from
different/multiple runs. The collection includes replay duplicates and a
manually republished subscription-5 message. It does **not** prove that one
uninterrupted full-PCAP replay completed.