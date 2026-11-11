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
These are the known issues, currently being addressed with Cisco IOS XR 25.4.2, CSCws28882, CSCwt86333 YANG-Push Publisher, libyang YANG library and NetCalyx YANG-Push Receiver.

subscription_id=11, push-change-update		libyang, anydata validation does not cover instance data not being encoded from the schema root
subscription_id=21, push-change-update		libyang, anydata validation does not cover instance data not being encoded from the schema root
subscription_id=23, push-change-update		libyang, anydata validation does not cover instance data not being encoded from the schema root
subscription_id=25, push-change-update		libyang, anydata validation does not cover instance data not being encoded from the schema root
subscription_id=27, push-change-update		libyang, anydata validation does not cover instance data not being encoded from the schema root
subscription_id=83, push-update, 					Cisco IOS XR 25.4.2, error=Node "policy-timestamp" not found as a child of "statistics" node. 
subscription_id=84, push-update, 					Cisco IOS XR 25.4.2, error=Node "policy-timestamp" not found as a child of "statistics" node. 
subscription_id=94, push-update, 					Cisco IOS XR 25.4.2, error=Invalid enumeration value "selection -point". 

### Cisco IOS XR DDTS
•	CSCws28882, openconfig-bfd deviations causing YANG schema validation failures in YANG-Push subscription id 23, 25 and 27
•	CSCwt86333, emsd crashes with SIGSEGV when deleting YANG-Push on-change subscription 11 on 8712-MOD-M (ATLAS) with large amounts of interfaces.
•	TBD, Empty data on 8011-32Y8L2H2FH and 8011-4G24Y4H-I (Glandon and Grand Colombier) on YANG-Push subscription 6.
