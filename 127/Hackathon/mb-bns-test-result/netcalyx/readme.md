## Test Result Summary for YANG Message Broker Consumer Integration Testing

| Component       | Name         | Test Case                                                                          | Passed/Failed/Partial    |
|-----------------|--------------|------------------------------------------------------------------------------------|--------------------------|
| Receiver        | NetCalyx     | Verify YANG-Push Receiver Content                                                  | Passed                   |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher                                    | Passed                   |
| Receiver        | NetCalyx     | Verify that for all YANG-Push Subscriptions Notifications are received             | Failed                   |
| Receiver        | NetCalyx     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed                   |
| Producer        | NetCalyx     | Verify that for all YANG-Push Subscriptions at least one Message is produced       | Passed                   |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable        | Passed                   |
| Consumer        | NetCalyx     | Verify that for all YANG-Push Subscriptions Messages are received                  | Passed                   |
| Consumer        | NetCalyx     | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained          | Passed                   |
| Consumer        | NetCalyx     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed                   |


### Test Result Comments for YANG Message Broker Consumer Integration Testing
These are the known issues, currently being addressed with 6Wind VSR YANG-Push Publisher and NetCalyx YANG-Push Receiver.

subscription_id=100, push-update					NetCalyx 0.3 YANG-Push Receiver, "identityref by" YANG modules not resolved
subscription_id=102, push-update					NetCalyx 0.3 YANG-Push Receiver, "identityref by" YANG modules not resolved
subscription_id=103, push-update          6Wind VSR 3.999.0.2026.10.16 notification content empty
subscription_id=105, subscription-started	6Wind VSR 3.999.0.2026.10.16 doesn't send subscription-started and push-update notifications
subscription_id=106, push-update					NetCalyx 0.3 YANG Message Broker Consumer, https://github.com/network-analytics/NetCalyx/issues/71

