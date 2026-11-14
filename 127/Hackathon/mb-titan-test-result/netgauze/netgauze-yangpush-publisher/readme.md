## YANG-Push Publisher - PCAP Replay

Cisco IOS XR `ipt-age923-b-aac-01`, YANG-Push over UDP-Notif, captured 2026-10-26 (files in this directory):

| File | Content |
|------|---------|
| `ipt-age923-b-aac-01-yp-udpnotif-202610261504.pcap` | the capture, `10.215.217.123 -> :10101` |
| `repro-config.yaml` | replay configuration: `10.215.217.123` mapped to `127.0.0.123`, collector `127.0.0.1:8123`, `time_factor: 1.0` |
| `traffic-reproducer-titan.log` | output of the replay of this run |
| `ipt-age923-b-aac-01-nc-*.xml`, `ipt-age923-b-aac-01-yp-subscription-*.xml` | device NETCONF dumps as published; each holds only an `Authentication failed` message |

```bash
tcpdump -nr ipt-age923-b-aac-01-yp-udpnotif-202610261504.pcap 'udp dst port 10101' | wc -l                            # 6075
tcpdump -nr ipt-age923-b-aac-01-yp-udpnotif-202610261504.pcap 'udp dst port 10101' | awk '{print $3}' | sort -u | wc -l  # 35
```

| Capture | |
|---------|---|
| UDP-Notif packets / notifications | 6,075 / 459 (35 subscription-started, 278 push-update, 146 push-change-update) |
| Subscriptions | 35: 1-6, 11-23, 25, 27, 81-94, each sent from its own UDP source port |
| Duration | 407.9 s |
| UDP-Notif message ids | one counter per source port: 80 distinct ids, 43 of them used on more than one port |
| Notifications of more than 64 segments | 21: subscription 3 (7 x 91 segments), 85 (7 x 416-420), 88 (7 x 92); all others have at most 62 |

The capture is replayed in real time with `tools/replay-udp-notif.py`, which sends every packet from its original UDP
source port (`tools/run-lab.sh --replayer udp-notif`). This is required for this device: the message ids repeat across
source ports and the receiver reassembles segments per peer address, port and message id, so a replay from a single
source port would mix the segments of different subscriptions.

```bash
python tools/replay-udp-notif.py -v --cfg repro-config.yaml
sent 5000 packets (35 source ports)
replayed 6075 packets from 35 source port(s) in 407.9s (time_factor 1.0), skipped 0
|   Packet sent   |   0   |  0  |  0  |    6075    |      0      |      --      |       --      |
```

NetGauze 0.14 decoded all 459 notifications (no reassembly or decode error, no kernel UDP receive-buffer drop) without
any pause in the replay. The NetCalyx 0.4.0 cross-check needs `--warmup-gap 90`, a 90 s pause after the
subscription-started burst (`warm-up: 17 packets sent in the first 2.0s of capture, pausing 90.0s`).
