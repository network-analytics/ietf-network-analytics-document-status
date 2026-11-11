## Test Result Summary for YANG Message Broker Consumer Integration Testing

| Component       | Name         | Test Case                                                                          | Passed/Failed/Partial    |
|-----------------|--------------|------------------------------------------------------------------------------------|--------------------------|
| Receiver        | NetCalyx     | Verify YANG-Push Receiver Content                                                  | Passed                   |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher                                    | Passed                   |
| Receiver        | NetCalyx     | Verify that for all YANG-Push Subscriptions Notifications are received             | Passed                   |
| Receiver        | NetCalyx     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed                   |
| Producer        | NetCalyx     | Verify that for all YANG-Push Subscriptions at least one Message is produced       | Passed                   |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable        | Passed                   |
| Consumer        | NetCalyx     | Verify that for all YANG-Push Subscriptions Messages are received                  | Passed                   |
| Consumer        | NetCalyx     | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained          | Passed                   |
| Consumer        | NetCalyx     | Verify that for all YANG-Push Subscriptions at least one Notification is validated | Failed                   |


### Test Result Comments for YANG Message Broker Consumer Integration Testing
These are the known issues, currently being addressed with Huawei YANG-Push Publisher, libyang YANG library and NetCalyx YANG-Push Receiver.

subscription_id=27, push-change-update		libyang, anydata validation does not cover instance data not being encoded from the schema root
subscription_id=7, push-update						Huawei VRP R205C10SPH203 YANG-Push Publisher, Invalid union value
subscription_id=9, push-update						Huawei VRP R205C10SPH203 YANG-Push Publisher, Invalid union value
subscription_id=11, push-update						Huawei VRP R205C10SPH203 YANG-Push Publisher, Invalid union value