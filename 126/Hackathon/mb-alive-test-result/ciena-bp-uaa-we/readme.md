## Test Result Summary for YANG Message Broker Consumer Integration Testing

| Component       | Name         | Test Case                                           | Passed/Failed/Partial    |
|-----------------|--------------|-----------------------------------------------------|--------------------------|
| Receiver        | NetGauze     | Verify YANG-Push Receiver Content                   | X                        |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher     | X                        |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions Notifications are received         | X                        |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated        | X                        |
| Producer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Message is produced        | X                        |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable         | X                        |
| Consumer        | UAA Workflow | Verify that for all YANG-Push Subscriptions Messages are received          | X                        |
| Consumer        | UAA Workflow | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained         | X                        |
| Consumer        | UAA Workflow | Verify that for all YANG-Push Subscriptions at least one Notification is validated         | X                        |
| Consumer        | UAA Workflow | Verify that Mockup Telemetry Messages are validated | X                        |
|                 |              |                                                     |                          |

### Test Result Comments for YANG Message Broker Consumer Integration Testing

your text