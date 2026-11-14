## YANG-Push Publisher - PCAP Replay

Capture `ipt-lss923-a-mbi-05--yp-udpnotif-20261009-1357.pcap` (Huawei NE8000 eBNG, 613 s): 37,337 UDP-Notif packets
from `10.215.134.62`, one UDP source port (60520), to `138.187.58.51:10100` (34,534) and `138.187.58.50:10100` (2,803),
each stream with its own message-id counter. 22,904 packets are segments; 25,003 messages, of which 5 are incomplete
in the capture itself (one of two segments missing: four push-updates of subscription 2 and one message without its
first segment), leaving 24,998 notifications: 44 subscription-started, 44 subscription-terminated, 24,827 push-update,
83 push-change-update.

44 subscriptions: 1-4, 100-102, 104-106, 200-220, 300-306, 400-405 (103 and 307 of Swisscom's table are not in the
capture). The device sends 34,615 packets in the first 30 s (on-start sync of all subscriptions, 5,053 packets/s
peak), then about 5 packets/s; every subscription ends with a `subscription-terminated`.

Replayed in real time with `tools/replay-udp-notif.py` and `repro-config.yaml` (this directory): source
`10.215.134.62` mapped to `127.0.0.62`, collector `127.0.0.1:8123`, original UDP source port kept, no pause.

```bash
venv/bin/python tools/replay-udp-notif.py -v --cfg repro-config.yaml --time-factor 1.0
replayed 37337 packets from 1 source port(s) in 613.3s (time_factor 1.0), skipped 0
|   Packet sent   |   0   |  0  |  0  |    37337    |      0      |      --      |       --      |
```
Full output: `traffic-reproducer-ebng.log`. The collector received every packet (kernel `RcvbufErrors` 0).
