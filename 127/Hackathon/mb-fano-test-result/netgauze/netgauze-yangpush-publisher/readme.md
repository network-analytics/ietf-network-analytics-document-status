## YANG-Push Publisher - PCAP Replay

`ipd-zbl1536-s-ah-79-yp-udpnotif-20261020-1651.pcap`: 45,148 UDP-Notif packets from `10.80.32.79` to UDP port 10100,
captured 2026-10-20 14:52:43 - 16:42:36 UTC (6,593 s) on a Huawei FANO OLT with 27 YANG-Push subscriptions. The
`ipd-zbl1536-s-ah-79-netconf-*.xml` files are the device's NETCONF dumps (YANG library, subscriptions, capabilities).

Replayed with [traffic-reproducer](https://github.com/network-analytics/traffic-reproducer) and `repro-config.yaml`
(this directory): source `10.80.32.79` mapped to `127.0.0.79`, collector `127.0.0.1:8123`, `time_factor: 0.05` (20x).

```bash
cd traffic-reproducer && venv/bin/python main.py -v --cfg repro-config.yaml > traffic-reproducer-fano.log 2>&1
grep -a -E 'Elapsed time|Packet sent|Packet filtered' traffic-reproducer-fano.log | tail -3

INFO:root:Elapsed time: 331.53s
|   Packet sent   |   0   |  0  |  0  |    45148    |      0      |      --      |       --      |
| Packet filtered |   0   |  0  |  0  |      0      |      0      |      0       |       0       |
```
All 45,148 packets were sent in 332 s and none was dropped by the kernel on the receiver socket. The run is driven by
`tools/run-all.sh fano` (see `mb-test-setup/readme.md`).
