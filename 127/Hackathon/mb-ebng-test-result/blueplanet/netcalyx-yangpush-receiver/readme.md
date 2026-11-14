## eBNG NetCalyx YANG-Push Receiver

Receiver `10.190.33.167:10000/UDP`; PCAP source `10.215.134.62` was mapped to
replay peer `10.190.33.167`. The active server cache during this run was
`/home/bpadmin/netcalyx-migration/caches/ebng`.

### Cache Mismatch

Replayed notifications carry router content ID `190100522`. The subscription
metadata in the active eBNG cache instead uses `2300156437`; no matching
`190100522` subscription records were found in the installed dataset caches.
The repository's [eBNG cache archive](ebng-netcalyx-receiver-cache-content.tar.gz)
is byte-identical to the ALIVE archive, so it is not the complete eBNG cache.

On a cache miss NetCalyx attempted a YANG Library fetch from the replay peer at
`10.190.33.167:12345`. That SSH/NETCONF connection was refused. The collector
later used its default schema ID `630`; see the
[producer results](../netcalyx-messagebroker-producer/readme.md).

### Collector Log, 2026-11-12

The [filtered journal extract](ebng-collector-20261112T164053Z-164643Z.log)
covers 16:40:53-16:46:43 UTC and retains cache misses, SSH errors, fetch
failures, fallback warnings, validation drops, and producer errors when present.

| Event | Log entries |
| --- | ---: |
| Cache miss and fetch started | 44 |
| SSH connection errors | 484 |
| YANG Library fetch failed | 44 |
| Default schema ID warning | 1,000 |
| Validation-drop or Kafka producer error matching the extract filter | 0 |

These are log events, not counts of unique notifications or a validation pass
rate. The extract does not establish successful receiver validation.

For subscription 217, the cache miss was logged at **16:40:55 UTC**, the fetch
failure at **16:44:34 UTC**, and fallback warnings immediately afterward. That
observed delay explains why messages appeared after the replay sender exited.

Obtain the correct eBNG receiver cache, including subscription metadata and
YANG modules, from the original device or NetCalyx team before relying on
device-specific schema validation.