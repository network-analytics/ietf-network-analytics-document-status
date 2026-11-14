## YANG-Push Publisher - PCAP Replay

`ipf-zbl1327-r-daisy-48-yp-udpnotif-20260918-0847-vrf501.pcap`: 11,620 UDP packets, one flow
`2001:db8:48::1 port 55411 -> UDP port 10100`, 4,943 s capture (Huawei NE8000, hostname `ipf-zbl1327-r-daisy-48`,
publisher id 16843789). 2,446 UDP-Notif messages (message ids 1-2446), 1,147 of them segmented (10,321 segment
packets): 16 `subscription-started`, 2,394 `push-update`, 36 `push-change-update` for 16 YANG-Push subscriptions
(1-7, 11-19).

| Subscription | subscription-started | push-update | push-change-update |
|--------------|----------------------|-------------|--------------------|
| 1            | 1                    | 82          |                    |
| 2            | 1                    | 82          |                    |
| 3            | 1                    | 324         |                    |
| 4            | 1                    | 81          |                    |
| 5            | 1                    | 999         |                    |
| 6            | 1                    | 164         |                    |
| 7            | 1                    | 81          |                    |
| 11           | 1                    | 1           | 10                 |
| 12           | 1                    | 164         |                    |
| 13           | 1                    | 3           |                    |
| 14           | 1                    | 246         |                    |
| 15           | 1                    | 1           |                    |
| 16           | 1                    | 82          |                    |
| 17           | 1                    | 2           | 4                  |
| 18           | 1                    | 82          |                    |
| 19           | 1                    |             | 22                 |

Four `push-update` messages are not valid JSON as sent by the device (message ids 17, 18, 19 and 23, subscriptions
15, 17, 17 and 13); see the receiver readme.

`ipf-zbl1327-r-daisy-48-nc-yanglibrary-20260911-0943.xml` is the YANG library of the device (content id
`2300156437`, the `router_content_id` of every notification).

### Replay

Replayed with traffic-reproducer and `repro-config.yaml` (this directory): source `2001:db8:48::1` mapped to `::1`,
packets with UDP destination port 10100 sent to the collector listener `[::1]:8123`, `time_factor: 0.05` (20x).

```bash
venv/bin/python main.py -v --cfg repro-config.yaml
tail -12 traffic-reproducer-alive.log | grep -E 'Elapsed|Packet sent|Packet filtered'
```

```
INFO:root:Elapsed time: 248.428s
|   Packet sent   |   0   |  0  |  0  |    11620    |      0      |      --      |       --      |
| Packet filtered |   0   |  0  |  0  |      0      |      0      |      0       |       0       |
```

All 11,620 packets were sent in 248 s and all 2,446 messages reached the receiver (0 kernel UDP receive-buffer
drops). Full output: `traffic-reproducer-alive.log`. The replay is started by `tools/run-all.sh alive`, see
`../../../mb-test-setup/readme.md`.
