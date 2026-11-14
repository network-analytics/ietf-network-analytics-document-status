## YANG Schema Registry - Latest ALIVE Replay Evidence

### Schema ID Used by the Blue Planet Consumer

All 339 failed payloads in the November 13 ALIVE replay reported schema ID 630.
Query the live Schema Registry:

```bash
curl -fsS http://10.190.33.167:8081/schemas/ids/630 \
	| jq '{schemaType, references: [.references[]?.name]}'
```

Observed: schema ID 630 is available and has type `YANG`. Its references include `iana-if-type`, `ietf-distributed-notif`, `ietf-inet-types`, `ietf-platform-manifest`, `ietf-udp-notif-transport`, `ietf-yang-push-revision`, `ietf-yang-push-telemetry-message`, `ietf-yang-structure-ext`, `ietf-yang-types`, `ietf-yp-notification`, and `ietf-yp-observation`.

The direct-reference response does not list `ietf-hardware` or `ietf-alarms`.
The latest replay produced 317 hardware `/component` unknown-element failures and
22 alarm notification unknown-element failures. The direct list alone does not
establish transitive closure. Four captured subscription-started controls
passed, and no YANG Library content-id leafref errors occurred in this run.

See the [consumer replay report](../blueplanet-messagebroker-consumer/readme.md) for subscription-level counts, payload excerpts, and exact diagnostics.