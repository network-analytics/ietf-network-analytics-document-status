## YANG-Push Publisher - PCAP Replay

`daisy-ietf-ipf-zbl1843-r-daisy-58-yp-udpnotif-20261022-1324.pcap` (the same file as in
`../../netcalyx/netcalyx-yangpush-publisher/`): 6WIND vRouter `daisy-ietf-ipf-zbl1843-r-daisy-58`, 60 UDP-Notif
packets `10.212.242.58 -> 10.212.242.2:10100`, 360 s. 25 packets are complete messages and 35 are segments of 2
larger messages: 27 notifications (6 subscription-started, 21 push-update) of 6 YANG-Push subscriptions.

| Subscription | Type      | Target                                                  | In the capture                   |
|--------------|-----------|---------------------------------------------------------|----------------------------------|
| 100          | on-change | `/if:interfaces/if:interface`                           | subscription-started + 1 update  |
| 101          | periodic  | `/if:interfaces/if:interface/if:statistics`             | subscription-started + 6 updates |
| 102          | on-change | `/hw:hardware`                                          | subscription-started + 1 update  |
| 103          | periodic  | `/hw:hardware/hw:component/hw:sensor-data`              | subscription-started + 6 updates |
| 104          | on-change | `/al:alarms/al:alarm-list`                              | subscription-started + 1 update  |
| 105          | on-change | `/lldp:lldp`                                            | nothing (state `invalid`)        |
| 106          | periodic  | `/vrouter:state/vrouter-tracker:tracker/vrouter-tracker:icmp-rtt` | subscription-started + 6 updates |

Types, targets and the state of 105 are from the device configuration,
`daisy-ietf-ipf-zbl1843-r-daisy-58-netconf-yp-subscription-20261022-1222.xml` (periodic: period 6000, on-change:
dampening-period 500 with sync-on-start). The other two NETCONF captures of the device are kept for reference:
`...-netconf-yanglibrary-20261022-1222.xml` (full YANG library, 392 `<module>` entries) and
`...-netconf-systems-capa-20261022-1222.xml`.

### Replay
[traffic-reproducer](https://github.com/network-analytics/traffic-reproducer) with `repro-config.yaml` (this
directory): source `10.212.242.58` mapped to `127.0.0.58`, destination `127.0.0.1:8123`, `time_factor: 0.05` (20x).

```bash
cd traffic-reproducer && venv/bin/python main.py -v --cfg repro-config.yaml
|      metric     | ipfix | bmp | bgp | udp_generic | tcp_generic | unknown peer | unknown proto |
|   Packet sent   |   0   |  0  |  0  |      60     |      0      |      --      |       --      |
| Packet filtered |   0   |  0  |  0  |      0      |      0      |      0       |       0       |
INFO:root:Elapsed time: 19.522s
```
Full output: `traffic-reproducer-bns.log`. All 60 packets were sent in 19.5 s and none was dropped by the kernel
(`rcvbuf_errors` 0); the receiver decoded all 27 notifications (`../netgauze-yangpush-receiver/readme.md`).
