## Test Result Summary for YANG Message Broker Consumer Integration Testing

| Component       | Name         | Test Case                                           | Passed/Failed/Partial    |
|-----------------|--------------|-----------------------------------------------------|--------------------------|
| Receiver        | NetGauze     | Verify YANG-Push Receiver Content                   | Passed                   |
| Publisher       | PCAP Replay  | Replay YANG Notification as YANG-Push Publisher     | Passed                   |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions Notifications are received        | Passed                   |
| Receiver        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated        | Passed                   |
| Producer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Message is produced        | Passed                   |
| Schema Registry | Apache Kafka | Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable        | Passed                   |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions Messages are received        | Passed                   |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions all YANG schemas are obtained        | Passed                   |
| Consumer        | NetGauze     | Verify that for all YANG-Push Subscriptions at least one Notification is validated        | Passed                   |


### Test Result Comments for YANG Message Broker Consumer Integration Testing

NetGauze uses libyang 4.2.2 currently. With libyang 5.4.9 YANG anydata strict validation [draft-ietf-netmod-yang-anydata-validation](https://datatracker.ietf.org/doc/html/draft-ietf-netmod-yang-anydata-validation "Validating anydata in YANG Library context") and YANG structure [RFC 8791](https://datatracker.ietf.org/doc/html/rfc8791 "YANG Data Structure Extensions") support was refactored to support anydata validation with YANG data structures. See [https://github.com/CESNET/libyang/releases](https://github.com/CESNET/libyang/releases "Libyang Release Notes").

Since NetGauze as YANG-Push Receiver validation passed succesfully, it is expected once NetGauze uses libyang 5.4.9 that also the YANG Message Broker Consumer validation is successful.
