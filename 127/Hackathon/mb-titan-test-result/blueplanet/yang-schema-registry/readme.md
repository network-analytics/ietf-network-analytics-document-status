## Titan YANG Schema Registry Evidence

Nov 12 lab endpoint: `http://10.190.33.167:8081` (HTTP/plaintext). Nine schema
IDs were observed on Kafka records and resolved:

`1684`, `1687`, `1690`, `1694`, `1696`, `1699`, `1711`, `1716`, and `1720`.

The folder contains each root response and
[an archive with all 83 recursively referenced subject/version responses](titan-confluent-schemaregistry-schema-content.tar.gz).
The [Titan Registry log extract](schema-registry-titan-20261112.log) records the
failed registration attempts.

### Reproduce Schema Reads

```bash
curl -fsS http://10.190.33.167:8081/schemas/types
curl -fsS http://10.190.33.167:8081/schemas/ids/1684
curl -fsS http://10.190.33.167:8081/schemas/ids/1687
curl -fsS http://10.190.33.167:8081/schemas/ids/1690
curl -fsS http://10.190.33.167:8081/schemas/ids/1694
curl -fsS http://10.190.33.167:8081/schemas/ids/1696
curl -fsS http://10.190.33.167:8081/schemas/ids/1699
curl -fsS http://10.190.33.167:8081/schemas/ids/1711
curl -fsS http://10.190.33.167:8081/schemas/ids/1716
curl -fsS http://10.190.33.167:8081/schemas/ids/1720
```

The Registry logged **390 HTTP 422** responses for subject
`netcalyx.labCisco-IOS-XR-openconfig-platform-pipeline-counters-q200-ext`,
whose submitted YANG schema was 1,334,408 bytes. The captured log records the
status and subject but not the response body or an associated parser exception;
the precise cause is therefore unconfirmed. This registration failure
corresponds with collector producer errors; some other Titan schemas were
successfully resolved.

The historical `119xxx` schema IDs in the neighboring NetCalyx result belong to
an earlier run/environment. Use the IDs observed on the current Kafka record
headers, not those historical IDs.