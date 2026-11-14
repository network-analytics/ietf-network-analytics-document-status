## ALIVE YANG-Push Publisher Replay

PCAP: `ipf-zbl1327-r-daisy-48-yp-udpnotif-20260918-0847-vrf501.pcap`.
The original PCAP and YANG Library XML are retained unchanged in this folder.

The adjacent [NetCalyx result summary](../../netcalyx/readme.md) and its
[producer evidence](../../netcalyx/netcalyx-messagebroker-producer/readme.md)
record the historical Sept 18 receiver validations and schema lookups. Those
results are not the Nov 10 lab retry results below.

### Replay Configuration

Server: `10.190.33.167`; NetCalyx receiver: UDP `10.190.33.167:10000`.

| Setting | Value |
| --- | --- |
| PCAP source IP | `2001:db8:48::1` (IPv6) |
| Replay source IP | `10.190.33.167` (IPv4) |
| Selected original UDP destination port | `10100` |
| Replay speed | 10x (`time_factor: 0.1`) |
| Replay YAML on server | `/home/bpadmin/netcalyx-migration/repro-alive.yaml` |

The traffic-reproducer extracts the UDP payload and sends it using an IPv4
socket bound to `repro_ip`; the capture's IPv6 source is mapped to the lab's
IPv4 collector address.

The server-side `/home/bpadmin/netcalyx-migration/repro-alive.yaml` uses:

```yaml
pcap:
  - /home/bpadmin/netcalyx-migration/downloads/ipf-zbl1327-r-daisy-48-yp-udpnotif-20260918-0847-vrf501.pcap
time_factor: 0.1
keep_open: false
no_sync: true
network:
  map:
    - src_ip: 2001:db8:48::1
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

### Run

Start a Kafka consumer in another SSH session before replay to observe new
messages:

```bash
kcat -C -b 10.190.33.167:9092 -t telemetry-yang -o end \
  -f 'headers=%h\n%s\n'
```

Run one ALIVE replay at a time:

```bash
cd /home/bpadmin/netcalyx-migration
bash run-replay.sh alive 120
```

For the full capture, use `bash run-replay.sh alive 0`. The wrapper switches
`/var/cache/netcalyx/yang_schemas` to the ALIVE cache and restarts the NetCalyx
collector. Do not switch caches during an active replay.

### Verification Status

The neighboring [NetCalyx test results](../../netcalyx/netcalyx-yangpush-publisher/)
record the Sept 18 ALIVE replay. On Nov 10, lab replay traffic reached the
receiver, confirming the IPv6-to-IPv4 mapping works. A bounded replay after cache
restoration reported two UDP packets sent and exit code 137. It did not establish
a completed replay or successful Kafka production. Kafka offset checks around
the retries showed no new records; the recorded topic end offset was **39419**.

Replayer packet counts do not equal messages successfully validated or published
by NetCalyx. See the [producer results](../netcalyx-messagebroker-producer/readme.md)
for the exact Nov 10 Registry and YANG cache errors, and the historical
[NetCalyx receiver results](../../netcalyx/netcalyx-yangpush-receiver/readme.md)
for the Sept 18 successful and failed validation examples.