## BNS YANG-Push Publisher Replay

PCAP: `daisy-ietf-ipf-zbl1843-r-daisy-58-yp-udpnotif-20261022-1324.pcap`.
The original PCAP and NETCONF XML files in this folder are unchanged.

### Capture and Address Mapping

| Item | Value |
| --- | --- |
| PCAP source IP | `10.212.242.58` |
| Replay source (`repro_ip`) | `10.190.33.167` |
| Captured UDP destination port | `10100` |
| NetCalyx destination | `10.190.33.167:10000/UDP` |
| PCAP UDP packets | 60 over about 360 seconds |
| Replay speed | 10x (`time_factor: 0.1`) |

The server configuration is `/home/bpadmin/netcalyx-migration/repro-bns.yaml`:

```yaml
pcap:
  - /home/bpadmin/netcalyx-migration/downloads/daisy-ietf-ipf-zbl1843-r-daisy-58-yp-udpnotif-20261022-1324.pcap
time_factor: 0.1
keep_open: false
no_sync: true
optimize:
  threading: false
  preload: false
network:
  map:
    - src_ip: 10.212.242.58
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

### Replay

The full capture was run on Nov 11 through the server wrapper, which selects the
BNS cache and restarts NetCalyx. The replay completed in **37.081 seconds**,
sent all **60 packets**, and exited with status **0**.

```bash
ssh bpadmin@10.190.33.167
cd /home/bpadmin/netcalyx-migration
bash run-replay.sh bns 0
```

In a second session, observe newly produced Kafka records:

```bash
kcat -C -b 10.190.33.167:9092 -t telemetry-yang -o end \
  -f 'headers=%h\n%s\n'
```

The [saved replay log](replay-bns-full-20261111.log) is the Nov 11 run. The
server's producer record range and Schema Registry outcomes are documented in
the [producer results](../netcalyx-messagebroker-producer/readme.md).