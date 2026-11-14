## Titan NetCalyx Message Broker Producer

Server `10.190.33.167`; Kafka `10.190.33.167:9092` (PLAINTEXT); topic
`telemetry-yang`; Schema Registry `http://10.190.33.167:8081` (HTTP). The
Titan hostname is `ipt-age923-b-aac-01`; the capture source `10.215.217.123` was
replayed with key/peer `10.190.33.167`.

### Kafka Results, 2026-11-12

Partition 0 advanced from offset **47799** to end offset **47925**, yielding 126
records: **98 push updates** and **28 subscription-started** notifications for
subscription IDs 81-94. Each record includes `schema-id` and
`content-type=application/yang.data+json`. The full Kafka record archive is not
retained; representative records and
[subscription-schema-summary.json](subscription-schema-summary.json) are.

| Subscription | Schema ID | Cache directory ID | Push updates | Started |
| ---: | ---: | --- | ---: | ---: |
| 81 | 1684 | `ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3` | 14 | 2 |
| 82 | 1687 | `369536a436f0d21eabc81ef220e3fca8ac933c667eb26937ef05fb4d499c6fed` | 0 | 2 |
| 83 | 1696 | `0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114` | 0 | 2 |
| 84 | 1696 | `0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114` | 0 | 2 |
| 85 | 1690 | `8a199e95f7dc22c9d48e427d76647fd6dd56e046501b2370d76c03d573eda4c3` | 0 | 2 |
| 86 | 1694 | `9b24ab29c609d764dff3c5d9b7326056a7bcb9e680be565b9f2d15fca86e1b00` | 6 | 2 |
| 87 | 1699 | `da952479f7ed21edea0aa95fec17fdc2eb1622954201c5216bbd12655a44c287` | 12 | 2 |
| 88 | 1711 | `1c5665b1bda78f76baaec1afe3db9eb491af2d770ecc678d9b2fbf3bb4dec5cf` | 0 | 2 |
| 89 | 1716 | `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 14 | 2 |
| 90 | 1716 | `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 12 | 2 |
| 91 | 1716 | `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 14 | 2 |
| 92 | 1716 | `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 14 | 2 |
| 93 | 1716 | `801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd` | 12 | 2 |
| 94 | 1720 | `7d667a00976c1fe2f927b065214b45bc398f2192bd05572e424a60d12e3ed0f9` | 0 | 2 |

The cache directory IDs above are distinct from the `yang-library-content-id`
carried in the Kafka payload metadata. The captured records use router content ID
`62119e3c6576f04d616c2fa8e7c4bb89abc1f5a3`.

Sample files are named `tm-sNNN-<notification>.json`; examples include
[subscription 87 push-update](tm-s087-push-update.json) and
[subscription 81 push-update](tm-s081-push-update.json). Subscription 83 has
only a start record in Kafka although its cache includes a configured update.

### Producer Registration Errors

The collector recorded **195** `Error sending message to Kafka` events during
the replay window. The Registry recorded **390 HTTP 422** responses while
registering subject
`netcalyx.labCisco-IOS-XR-openconfig-platform-pipeline-counters-q200-ext`
(schema size 1,334,408 bytes). The logged response body/parser cause was not
captured, so the precise reason for this Titan-time 422 is unconfirmed. See the
[Registry log extract](../yang-schema-registry/schema-registry-titan-20261112.log).

Historical `119xxx` IDs in the neighboring NetCalyx result belong to another
run/environment; the Nov 12 Titan records use IDs 1684-1720 listed above.