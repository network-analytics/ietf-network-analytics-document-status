## FANO YANG Schema Registry Evidence

Endpoint: `http://10.190.33.167:8081` (HTTP, not SSL).
All schema IDs observed in the exported FANO records were retrieved successfully:

- [schema_id_983.json](schema_id_983.json): 128 direct references.
- [schema_id_985.json](schema_id_985.json): 129 direct references.
- [schema_id_993.json](schema_id_993.json): 131 direct references.

[fano-confluent-schemaregistry-schema-content.tar.gz](fano-confluent-schemaregistry-schema-content.tar.gz)
contains those three responses plus **363 distinct recursively resolved
subject/version responses** under `references/`. Reference sets overlap.
The export includes the schema text and references returned by this server.

### Reproduce Retrieval

```bash
curl -fsS http://10.190.33.167:8081/schemas/types
curl -fsS http://10.190.33.167:8081/schemas/ids/983
curl -fsS http://10.190.33.167:8081/schemas/ids/985
curl -fsS http://10.190.33.167:8081/schemas/ids/993
```

Use the schema ID from each message header; schema IDs are environment-specific.
Do not use 236779/236780/236781 from the neighboring NetCalyx test environment.
Successful registry retrieval is not evidence that Blueplanet fetched or
validated the schema; its consumer-side verification remains pending.