## eBNG YANG Schema Registry Evidence

Lab endpoint: `http://10.190.33.167:8081` (HTTP). The 1,000 eBNG records in
the captured Kafka range all carry schema ID **630**, which resolves to the
saved [YANG schema response](schema_id_630.json) with 11 direct references.

The collector log identifies 630 as the **default schema ID** used after
eBNG cache misses and failed YANG Library fetches. Resolving this root schema
does not establish that the device-specific YANG Library or all referenced
schemas needed for eBNG payload validation are available. Only the root response
was exported for this run; its referenced subject/version responses were not
captured.

```bash
curl -fsS http://10.190.33.167:8081/schemas/ids/630 | jq .
```

See the [receiver log and cache analysis](../netcalyx-yangpush-receiver/readme.md)
for the fetch failures and fallback timing.