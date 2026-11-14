## eBNG YANG-Push Publisher Evidence

### Capture

PCAP: [ipt-lss923-a-mbi-05--yp-udpnotif-20261009-1357.pcap](ipt-lss923-a-mbi-05--yp-udpnotif-20261009-1357.pcap).
The original capture is unchanged.

| Item | Observed value |
| --- | --- |
| Source IP | `10.215.134.62` |
| Destination UDP port | `10100` |
| Destination `138.187.58.50` | 2,803 UDP frames |
| Destination `138.187.58.51` | 34,534 UDP frames |
| Total captured frames | 37,337 |
| Capture duration | 613.329246 seconds |
| PCAP SHA-256 | `1101a64f1c46211093f0d6f4a5142bdffe99c2439ce802425b6f08becc08de7e` |

### Server Replay

The full capture was replayed on `10.190.33.167` on 2026-11-12 from
11:35:50 to 11:36:55 UTC using NetCalyx's UDP listener on port `10000`.
The configured source mapping rewrote `10.215.134.62` to `10.190.33.167`;
the replay destination was `10.190.33.167:10000/UDP`. The configured replay
speed was 10x (`time_factor: 0.1`).

The replayer reported **37,337 UDP packets sent**, **0 packets filtered**,
63.14 seconds elapsed, and exit code **0**. Its sender-side counters do not
establish that NetCalyx received, validated, or published every packet. The
[saved replay log](replay-ebng-full-20261112T113550Z.log) was copied from
`/home/bpadmin/netcalyx-migration/replay-ebng-full-20261112T113550Z.log`.

The server configuration is `/home/bpadmin/netcalyx-migration/repro-ebng.yaml`.
The replay was run with:

```bash
cd /home/bpadmin/netcalyx-migration
bash run-replay.sh ebng 0
```

The wrapper switches the active receiver cache and restarts NetCalyx. The eBNG
receiver archive in this repository is identical to the ALIVE archive, and the
server eBNG cache has only three of the six trees listed in the historical eBNG
receiver results. The correct eBNG cache is needed before downstream receiver
validation or Kafka production can be assessed reliably.