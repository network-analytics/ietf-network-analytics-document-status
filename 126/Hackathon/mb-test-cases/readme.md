## Test Cases for YANG Message Broker Consumer Integration Testing

The test setup consists of the following system components and workflow

```
  +------------------------------------------------------------+
  | DUT            YANG Message Broker Consumer                |
  |                                                            |
  +------------------------------------------------------------+
        |  ^                                   ^
(6) Get |  |                                   | (8) Validate
 Schema |  |                                   | Serialized Message
        |  |                                   | Schema on Consumer
        |  |                              +--------------------+
        |  |                              |    Apache Kafka    |
        |  |                              |   Message Broker   |
        |  |                              +--------------------+
        |  |                                   ^
        |  |                                   | (5) Serialize
        |  |                                   | YANG-Push Message
        |  |                                   | annotated Schema ID
        |  |                                   | on Producer
        |  |                                   |
        |  |                                   |
        |  | (7) Issue                    +--------------------+
        |  |      Schema                  |   NetGauze YANG    |
        |  |                              |   Message Broker   |
				v  |                    (3) Post  |     Producer       |
  +--------------------+          Schema  +--------------------+
  | Apache Kafka YANG  | <--------------- |     NetGauze       |
  |  Schema Registry   | ---------------> | YANG-Push Receiver |
  +--------------------+  (4) Issue       +--------------------+
                              Schema ID      ^        ^
                                             |        |
                                             |        |
                                             |        |
                                    (1) Copy |        |
                                       Files |        | (2) Publish
                          +--------------------+      | YANG-Push
                          | YANG-Push Receiver |      | Notification
                          |    Cache Content   |      | with
                          +--------------------+      | Subscriber
                                                      | ID
                                          +--------------------+
                                          | YANG-Push Publisher|
                                          |    PCAP Replayer   |
                                          +--------------------+
```
---

### Table of Contents

1.  [Step 1 – Verify YANG-Push Receiver Content (Receiver)]
2.  [Step 2 – Replay YANG Notification as YANG-Push Publisher (Publisher)]
3.  [Step 3 – Verify that for all YANG-Push Subscriptions Notifications are received (Receiver)]
4.  [Step 4 – Verify that for all YANG-Push Subscriptions at least one Notification is validated (Receiver)]
5.  [Step 5 – Verify that for all YANG-Push Subscriptions at least one Message is produced (Producer)]
6.  [Step 6 – Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable (Schema Registry)]
7.  [Step 7 – Verify that for all YANG-Push Subscriptions Messages are received (Consumer)]
8.  [Step 8 – Verify that for all YANG-Push Subscriptions all YANG schemas are obtained (Consumer)]
9.  [Step 9 – Verify that for all YANG-Push Subscriptions at least one Notification is validated (Consumer)]
10. [Step 10 – Verify that Mockup Telemetry Messages are validated (Consumer)]

---

### Step 1 – Verify YANG-Push Receiver Content (Receiver)

At the YANG-Push Receiver, verify that the provided YANG cache content for fano has been copied to /var/cache/netgauze//var/cache/netgauze/yang_schemas and latest NetGauze version is installed by issuing:

```bash
netgauze-collector --version (supported as of version 0.11)
ll /var/cache/netgauze/yang_schemas
```
---

### Step 2 – Replay YANG Notification as YANG-Push Publisher (Publisher)

As a YANG-Push Publisher replacement, replay the Swisscom provided fano YANG-Push notifications packet capture by issuing:

```bash
python main.py -v --cfg repro-config.yaml
```
---

### Step 3 – Verify that for all YANG-Push Subscriptions Notifications are received (Receiver)

At the YANG-Push Receiver, verify that for all 27 YANG-Push subscriptions that there is a unique contend_id. It must match with the Swisscom provided YANG cache contend. Note the generated schema_id by issuing below verification commands.

```bash
grep 10.190.64.79 /var/log/netgauze/netgauze-udpnotif-yangpush-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'
```
---

### Step 4 – Verify that for all YANG-Push Subscriptions at least one Notification is validated (Receiver)

At the YANG-Push Receiver, verify that for all 27 YANG-Push subscriptions at least one notification passed YANG schema validation successfully by issuing

```bash
grep 10.190.64.79 /var/log/netgauze/netgauze-udpnotif-yangpush-left.log | grep validated | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

---

### Step 5 – Verify that for all YANG-Push Subscriptions at least one Message is produced (Producer)

At the YANG Message Broker Producer, verify that for all 27 YANG-Push subscriptions at least one notification per subscription has been transformed and produced to the Message Broker, and note one example each by issuing:

```bash
grep 10.190.64.79 /var/log/netgauze/netgauze-udpnotif-yangpush-left.log | grep schemaID | grep "subscription_id=" | awk -F'subscription_id=' '!seen[$2+0]++'
```

---

### Step 6 – Verify that for all YANG-Push Subscriptions all YANG schemas are obtainable (Schema Registry)

At the YANG Schema Registry, verify for each previously observed YANG schema id, the schema content is obtainable by issuing the following commands (schema id needs to be adapted based on your previous output):

```bash
curl https://schema-registry.sbd.corproot.net/schemas/ids/230966 > schema_id_230966.json
curl https://schema-registry.sbd.corproot.net/schemas/ids/230968 > schema_id_230968.json
curl https://schema-registry.sbd.corproot.net/schemas/ids/231874 > schema_id_231874.json
tar -czvf fano-confluent-schemaregistry-schema-content.tar.gz schema_id_230966.json schema_id_230968.json schema_id_231874.json
```

---

### Step 7 – Verify that for all YANG-Push Subscriptions Messages are received (Consumer)

At the YANG Message Broker Consumer, verify that for all 27 YANG-Push subscriptions at least one notification per subscription has been consumed from the Message Broker and all necessary YANG schemas have been obtained from the Apache Kafka YANG Schema Registry by issuing (examples from NetGauze, needs to be adapted to your YANG Message Broker Consumer):

```bash
cd /opt/netgauze-bin
RUST_LOG=kafka_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-sbd.json -s https://schema-registry.sbd.corproot.net --group daisy.dev.tg12345 -t daisy.dev.device-yang-raw -n 10 -f | grep 10.190.64.79 > /tmp/fano-netgauze-mb-consumer-log.txt
ll /opt/netgauze-bin/kafka-yang-consumer-cache
```

---

### Step 8 – Verify that for all YANG-Push Subscriptions all YANG schemas are obtained (Consumer)

At the YANG Message Broker Consumer, verify that all YANG schemas have been successfully obtained from the Apache Kafka YANG Schema Registry by comparing the list of obtained YANG modules between NetGauze and your YANG Message Broker Consumer by issuing:

```bash
diff /opt/netgauze-bin/kafka-yang-consumer-cache/schema-id-230966/modules /path/to/your-yang-message-broker-consumer/schema-id-230966/modules
diff /opt/netgauze-bin/kafka-yang-consumer-cache/schema-id-230968/modules /path/to/your-yang-message-broker-consumer/schema-id-230968/modules
diff /opt/netgauze-bin/kafka-yang-consumer-cache/schema-id-231874/modules /path/to/your-yang-message-broker-consumer/schema-id-231874/modules
```

---

### Step 9 – Verify that for all YANG-Push Subscriptions at least one Notification is validated (Consumer)

At the YANG Message Broker Consumer, verify that all messages are successfully validated against schema, and note one example each by issuing (examples from NetGauze, needs to be adapted to your YANG Message Broker Consumer):

```bash
grep validation /tmp/fano-netgauze-mb-consumer-log.txt
```

---

### Step 10 – Verify that Mockup Telemetry Messages are validated (Consumer)

Mockup with kcat a YANG Message Broker Producer and produce 1 valid and 8 invalid Telemetry Messages. At the YANG Message Broker Consumer, verify that all messages are successfully validated against schema, and note each by issuing (examples from NetGauze YANG Message Broker Consumer, needs to be adapted to your YANG Message Broker Consumer:

```bash
jq -c . fano-yp1-tm-ietf-interfaces-valid.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid1-yang-8791structure-structurename-1level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid2-yang-8791structure-structurename-2level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid3-yang-7950schema-leafname-1level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid4-yang-7950schema-containername-2level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid5-yang-7950schema-leafcontent-1level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid6-yang-7950schema-leafcontent-2level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid7-yang-7950schema-leafmissing-1level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

jq -c . fano-yp1-tm-ietf-interfaces-invalid8-yang-7950schema-leafmissing-2level.json | kcat -P -H "schema-id=230966" -k "192.0.2.222" -b kafka.sbd.corproot.net:9093 -t daisy.dev.device-yang-raw

cd /opt/netgauze-bin
RUST_LOG=kafka_yang_consumer=trace,info ./kafka-yang-consumer -c librdkafka-sbd.json -s https://schema-registry.sbd.corproot.net --group daisy.dev.tg12345 -t daisy.dev.device-yang-raw -n 10 -f | grep 192.0.2.222 > /tmp/fano-netgauze-mb-consumer-log-mockups.txt
tar -czvf fano-netgauze-mb-consumer-log-mockups.tar.gz fano-netgauze-mb-consumer-log-mockups.txt
```