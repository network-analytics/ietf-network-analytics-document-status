## Titan YANG-Push Publisher Replay

PCAP: `ipt-age923-b-aac-01-yp-udpnotif-202610261504.pcap`. The original PCAP
and NETCONF XML files in this folder are unchanged.

### Capture and Address Mapping

| Item | Value |
| --- | --- |
| PCAP source IP | `10.215.217.123` |
| Replay source (`repro_ip`) | `10.190.33.167` |
| Captured UDP destination port | `10101` |
| NetCalyx destination | `10.190.33.167:10000/UDP` |
| PCAP UDP packets | 6,075 over about 408 seconds |
| Replay speed | 10x (`time_factor: 0.1`) |
| Server replay YAML | `/home/bpadmin/netcalyx-migration/repro-titan.yaml` |

### Replay on the Lab Server

Run one dataset replay at a time. The wrapper selects the Titan cache and
restarts NetCalyx; Kafka and Schema Registry must already be running.

```bash
ssh bpadmin@10.190.33.167
cd /home/bpadmin/netcalyx-migration
bash run-replay.sh titan 120
```

For an unbounded replay, use `bash run-replay.sh titan 0`. The capture's
original duration is about 6.8 minutes, or roughly 41 seconds at the configured
10x speed. Start a Kafka reader in another session before replay if you want to
watch new messages:

```bash
kcat -C -b 10.190.33.167:9092 -t telemetry-yang -o end \
  -f 'headers=%h\n%s\n'
```

### Captured Server Evidence

The Kafka offset range `47799-47924` contains 126 records for Titan hostname
`ipt-age923-b-aac-01`. The replay PCAP has 6,075 UDP packets. The replay stdout
was not retained on the server, so its completion status is not independently
verified; see [replay-titan-observations.txt](replay-titan-observations.txt) and
the [producer evidence](../netcalyx-messagebroker-producer/readme.md).
