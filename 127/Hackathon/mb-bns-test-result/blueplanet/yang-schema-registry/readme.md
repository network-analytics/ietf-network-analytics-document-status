## BNS YANG Schema Registry Results

Nov 11 lab endpoint: `http://10.190.33.167:8081` (HTTP/plaintext). Schema IDs
observed on the 18 newly produced BNS records were **1588, 1589, and 1591**.

- [schema_id_1588.json](schema_id_1588.json)
- [schema_id_1589.json](schema_id_1589.json)
- [schema_id_1591.json](schema_id_1591.json)
- [Three schemas and 40 referenced subject/version responses](6wind-bns-confluent-schemaregistry-schema-content.tar.gz)
- [Registry errors during replay](schema-registry-bns-20261111.log)

### Reproduce Schema Reads

```bash
curl -fsS http://10.190.33.167:8081/schemas/types
curl -fsS http://10.190.33.167:8081/schemas/ids/1588
curl -fsS http://10.190.33.167:8081/schemas/ids/1589
curl -fsS http://10.190.33.167:8081/schemas/ids/1591
```

The IDs are specific to this server and differ from the historical IDs
118694/118695/118697/118707/118828 in the neighboring NetCalyx result.

### Java/AWE Consumer Validation Evidence

The separate Java/AWE replay read 18 records using schema IDs 1588, 1589, and
1591. Its per-subscription results and exact validator diagnostics are in the
[Blue Planet consumer report](../blueplanet-messagebroker-consumer/readme.md).
The archived schema responses support these checks:

| Schema ID | Root subject/version | Relevant reference evidence |
|---:|---|---|
| 1588 | `netcalyx.labietf-telemetry-message` v11 | Direct references include `ietf-hardware` v2 and `ietf-yang-push-revision` v4. |
| 1589 | `netcalyx.labietf-telemetry-message` v12 | The root response does not directly reference `ietf-interfaces`. Its archived recursive reference closure contains `netcalyx.labietf-interfaces` v4 and `netcalyx.labietf-yang-push-revision` v4. |
| 1591 | `netcalyx.labietf-telemetry-message` v13 | Direct references include `ietf-alarms` v2 and `ietf-yang-push-revision` v4. |

The `ietf-yang-push-revision` v4 definition of
`ietf-yang-push-revision:yang-library-content-id` is:

```yang
leaf yang-library-content-id {
	type leafref {
		path "/yanglib:yang-library/yanglib:content-id";
	}
	config false;
}
```

The target schema is available through the archived reference chain:
`netcalyx.labietf-yang-library-augmentedby` v3 references
`netcalyx.labietf-yang-library` v1, which defines the top-level
`yang-library/content-id`. The Java failure is an instance-data resolution
failure: the notification contains the leafref value but not the referenced
YANG Library data node.

The archived `netcalyx.labietf-interfaces` v4 model makes the statistics
container mandatory through its required child:

```yang
container statistics {
	config false;
	leaf discontinuity-time {
		type yang:date-and-time;
		mandatory true;
	}
}
```

Thus a push-update containing an interface list entry but omitting
`statistics` fails the current strict data-tree validation. Since subscription
101 selects the statistics subtree, confirm the intended handling of partial
filtered data before deciding whether the producer or validator should change.

Reproduce the exact Registry reads:

```bash
SR=http://10.190.33.167:8081
curl -fsS "$SR/schemas/ids/1588" | jq '{schemaType, references: [.references[]?.name]}'
curl -fsS "$SR/schemas/ids/1589" | jq '{schemaType, references: [.references[]?.name]}'
curl -fsS "$SR/schemas/ids/1591" | jq '{schemaType, references: [.references[]?.name]}'
curl -fsS "$SR/subjects/netcalyx.labietf-yang-push-revision/versions/4" \
	| jq -r '.schema' | grep -n -A8 -B3 'leaf yang-library-content-id'
curl -fsS "$SR/subjects/netcalyx.labietf-interfaces/versions/4" \
	| jq -r '.schema' | grep -n -A15 'container statistics {'
```

### Registration Failure

Registration attempts for `netcalyx.labvrouter-aaa` returned HTTP 422
`Unprocessable Entity`, and the Registry logged YANG schema parsing errors.
The saved Registry extract does not contain the response body or a stack trace,
so the underlying exception cannot be independently verified from the retained
evidence. This prevented some BNS producer attempts from being written, although
schemas for the 18 records that were produced resolve successfully.