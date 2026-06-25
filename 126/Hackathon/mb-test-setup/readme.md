## Test Setup for YANG Message Broker Consumer Integration Testing

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

1. [Step 1 – Spin Up Apache Kafka and the YANG Schema Registry]
2. [Step 2 – Configure and Run NetGauze YANG-Push Receiver and YANG Message Broker Producer]
3. [Step 3 – Reproduce YANG-Push Notifications from Packet Captured]
4. [Step 4 – Reproduce Telemetery Mockup Messages]
5. [Step 5 – Consume Messages from Apache Kafka]

---

### Step 1 – Spin Up Apache Kafka and the YANG Schema Registry

#### 1.1 Start Apache Kafka Cluster

> **Note:** The example below provides a minimal single-node Docker Compose setup to get you started quickly. You should adapt it to match your own infrastructure, security requirements, and operational practices.

> **Imporant:** considering increasing the max heap memory cap (see below SCHEMA_REGISTRY_HEAP_OPTS parameter for the schema-reg container) for the JVM as otherwise you might observee out-of-memory errors. The schema-registry with the yang plugin (https://github.com/network-analytics/yang-kafka-integration) will need to load big yang module to do the schema comparison and thus needs more memory than with standard schema-registry use cases.

Create a file called `docker-compose.kafka.yml`:

```yaml
services:

  zookeeper:
    image: confluentinc/cp-zookeeper:7.8.0
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
    ports:
      - "2181:2181"

  kafka:
    image: confluentinc/cp-kafka:7.8.0
    depends_on: [zookeeper]
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_AUTO_CREATE_TOPICS_ENABLE: "true"
    ports:
      - "9092:9092"

  schema-registry:
    image: confluentinc/cp-schema-registry:7.8.0
    depends_on: [kafka]
    environment:
      SCHEMA_REGISTRY_HOST_NAME: schema-registry
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: kafka:9092
      SCHEMA_REGISTRY_LISTENERS: http://0.0.0.0:8081
      # yang-kafka-integration specific config
      SCHEMA_REGISTRY_SCHEMA_PROVIDERS: "ch.swisscom.kafka.schemaregistry.yang.YangSchemaProvider"
      SCHEMA_REGISTRY_HEAP_OPTS: -Xmx8192M
    ports:
      - "8081:8081"
    # yang-kafka-integration specific config
    volumes:
      - ./<LOCAL_PATH_TO_YANG-SCHEMA-REGISTRY-PLUGIN_JAR>:/usr/share/java/schema-registry/<JAR_NAME>
```

Start the cluster:

```bash
docker compose -f docker-compose.kafka.yml up -d
```

Verify all three containers are healthy:

```bash
docker compose -f docker-compose.kafka.yml ps
```

---

### Step 2 – Configure and Run NetGauze YANG-Push Receiver and YANG Message Broker Producer

#### 2.1 Obtain NetGauze

For installation instructions, refer to [collector crate README](https://github.com/NetGauze/NetGauze/tree/main/crates/collector).

#### 2.2 Create NetGauze Configuration

Create a file called `config-lab.yaml`. The configuration below is intentionally minimal:
- **No custom enrichment** – no external metadata sources needed for this lab
- **No custom YANG schemas** – the defaults from the schema cache are used
- **Dummy NETCONF block** – NETCONF will not actually connect; the block is required by the configuration schema but is not exercised during a PCAP replay

Replace every value marked with `<PLACEHOLDER>` before running the collector.

```yaml
runtime:
  threads: 4                        # Adjust to your machine's core count

logging:
  level: info # if you want more detailed logs for troubleshooting, set to "debug" or "trace"
  ansi: true

telemetry:
  url: http://localhost:4317/v1/metrics
  id: netgauze-udpnotif-telemetry
  exporter_timeout: 3000
  reader_interval: 60000
  reader_timeout: 3000

udp_notif:
  subscriber_timeout: 100

  listeners:
    - address: "0.0.0.0:<UDP_NOTIF_PORT>"   # e.g. "0.0.0.0:10000" – port NetGauze will listen on
      workers: 2

  # Directory where NetGauze stores runtime YANG schema cache
  cache_location: <PATH_TO_YANG_SCHEMAS_CACHE>   # e.g. /home/user/lab/lab-assets/yang_schemas

  # Dummy NETCONF block: no connection will be made
  netconf:
    username: dummy
    private_key_path: /dev/null
    port: 12345

  publishers:
    yang-lab:
      buffer_size: 1000
      endpoints:
        yang-endpoint: !TelemetryKafkaYang
          topic: <KAFKA_TOPIC>                         # e.g. telemetry-message-yang
          schema_registry_url: http://<SCHEMA_REGISTRY_HOST>:<SCHEMA_REGISTRY_PORT>
          producer_config:
            # this section follows the same format as a librdkafka producer configuration
            # refer to librdkafka documentation for all available options
            bootstrap.servers: <KAFKA_BROKER_HOST>:<KAFKA_BROKER_PORT>
            message.timeout.ms: "60000"
            queue.buffering.max.messages: "1000"
          writer_id: lab-netgauze-yang
          yang_converter:
            subject_prefix: <SUBJECT_PREFIX>           # Must match the prefix used during schema registration in Step 1.2
            root_schema_name: ietf-telemetry-message
            default_yang_lib_ref:
              content_id: ietf-telemetry-message-full
              yang_library_path: assets/yang/ietf-telemetry-message/yang-lib-full.xml
              yang_lib_ref_path: assets/yang/ietf-telemetry-message/
            extension_yang_lib_ref:
              content_id: ietf-telemetry-message-min
              yang_library_path: assets/yang/ietf-telemetry-message/yang-lib-min.xml
              yang_lib_ref_path: assets/yang/ietf-telemetry-message/
```

#### 2.3 Install Pre Obtained NetGauze Cache Content

Download https://github.com/network-analytics/ietf-network-analytics-document-status/blob/main/126/Hackathon/mb-fano-test-result/netgauze/netgauze-yangpush-receiver/fano-netgauze-receiver-cache-content.tar.gz to obtain the YANG-Push Receiver cache content for FANO.

https://github.com/network-analytics/ietf-network-analytics-document-status/blob/main/126/Hackathon/mb-alive-test-result/netgauze/netgauze-yangpush-receiver/alive-netgauze-receiver-cache-content.tar.gz to obtain the YANG-Push Receiver cache content for ALIVE.

https://github.com/network-analytics/ietf-network-analytics-document-status/blob/main/126/Hackathon/mb-titan-test-result/netgauze/netgauze-yangpush-receiver/titan-netgauze-receiver-cache-content.tar.gz to obtain the YANG-Push Receiver cache content for TITAN.

At the YANG-Push Receiver, extract the content into /var/cache/netgauze/yang_schemas to get the following folder structure (yang module files in modules sub-directory ommited for brevity)

```
ls 39ca5904e85cc172e3a44c36814691cf7b6eaf87b13d47f3b3a2b8729c81a241 454f881091a4f769f8549aee57d4a0215f2f4d1482e0dff38e9f7cc79105d90d 4564adb7ea03c798c15476b85ecde9868940dd82e023233102faed7400f93159 5486c5560687ac8e3ae53383027209e3af806d65c74d892c0077bd5932ce95be 5e64ed3d03fec04ebb52b0de2bd1276f267e2153bbee382c5c0cd6af5a5225c4 64b1f735c235c057215a7bd723023c2771693b1306bb6500968b70226228ee78 883bba6ecbe5bc27f7b9a2a4b17a14e1d78471a74f65ee473abaae5e3c0dd6b9 946a9b98f06c5007eb150a81fffeb53f5b32e21abaaaac67bae40865753bda7d 999922077db592666e46f664c2328392b6edf932dd3ead723c85b42ee8941eac 9dfb0389698bceb0c86d812d24a8c035d4bcc18db458e71994d779584c289d05 9ee10ed0e4aea47109a0688a6500d903f3c95a2c46f274da04fa909d173e8aab a38dc74e5c924ca3726b483cfb27bc27133a231d83df8b5e34f871b1a728e89b b7dd215db97eae1a19baaa5c880823d8d3174a9ba075b4e47260066d7060ddbd e10f60ee80e42b49acf6e961891af989efb8d8569ccb1e72a70fa54047b3915b ed349f1eeb21f22cbfa0b3c2b0f018708f53f7e23738080addaaef9e53bb06f0
39ca5904e85cc172e3a44c36814691cf7b6eaf87b13d47f3b3a2b8729c81a241:
modules  subscriptions-info.json  yang-lib.xml

454f881091a4f769f8549aee57d4a0215f2f4d1482e0dff38e9f7cc79105d90d:
modules  subscriptions-info.json  yang-lib.xml

4564adb7ea03c798c15476b85ecde9868940dd82e023233102faed7400f93159:
modules  subscriptions-info.json  yang-lib.xml

5486c5560687ac8e3ae53383027209e3af806d65c74d892c0077bd5932ce95be:
modules  subscriptions-info.json  yang-lib.xml

5e64ed3d03fec04ebb52b0de2bd1276f267e2153bbee382c5c0cd6af5a5225c4:
modules  subscriptions-info.json  yang-lib.xml

64b1f735c235c057215a7bd723023c2771693b1306bb6500968b70226228ee78:
modules  subscriptions-info.json  yang-lib.xml

883bba6ecbe5bc27f7b9a2a4b17a14e1d78471a74f65ee473abaae5e3c0dd6b9:
modules  subscriptions-info.json  yang-lib.xml

946a9b98f06c5007eb150a81fffeb53f5b32e21abaaaac67bae40865753bda7d:
modules  subscriptions-info.json  yang-lib.xml

999922077db592666e46f664c2328392b6edf932dd3ead723c85b42ee8941eac:
modules  subscriptions-info.json  yang-lib.xml

9dfb0389698bceb0c86d812d24a8c035d4bcc18db458e71994d779584c289d05:
modules  subscriptions-info.json  yang-lib.xml

9ee10ed0e4aea47109a0688a6500d903f3c95a2c46f274da04fa909d173e8aab:
modules  subscriptions-info.json  yang-lib.xml

a38dc74e5c924ca3726b483cfb27bc27133a231d83df8b5e34f871b1a728e89b:
modules  subscriptions-info.json  yang-lib.xml

b7dd215db97eae1a19baaa5c880823d8d3174a9ba075b4e47260066d7060ddbd:
modules  subscriptions-info.json  yang-lib.xml

e10f60ee80e42b49acf6e961891af989efb8d8569ccb1e72a70fa54047b3915b:
modules  subscriptions-info.json  yang-lib.xml

ed349f1eeb21f22cbfa0b3c2b0f018708f53f7e23738080addaaef9e53bb06f0:
modules  subscriptions-info.json  yang-lib.xml
```

> **IMPORTANT**: you need to change the `peer` IP address in **all** `subscriptions-info.json` files to match the `repro_ip` you configured in `repro-config.yaml`. The `peer` field must reflect the source IP that will actually appear in the replayed traffic.
>
> For example, if your `repro_ip` is `192.168.1.1`, update the `peer` field accordingly:
>
> ```json
> [
>   {
>     "peer": "192.168.1.1:10000",
>     "id": 15,
>     "content_id": "22934",
>     "target": {
>       "ietf-yang-push:datastore": "ietf-datastores:operational",
>       "ietf-yang-push:datastore-xpath-filter": "/ietf-hardware:hardware/component/huawei-energy-management-an:energy-consumption"
>     },
>     "models": [
>       "ietf-hardware",
>       "huawei-energy-management-an",
>       "ietf-subscribed-notifications"
>     ]
>   }
> ]
> ```
>
> The original PCAP in this example uses `10.190.64.79` as the source IP — replace it with your own `repro_ip` in every `subscriptions-info.json` file across all cache subdirectories.

#### 2.4 Start NetGauze

For instructions on how to run the collector, refer to the [collector crate README](https://github.com/NetGauze/NetGauze/tree/main/crates/collector).

---

### Step 3 – Reproduce YANG-Push Notifications from Packet Captured

Download https://github.com/network-analytics/ietf-network-analytics-document-status/tree/main/126/Hackathon/mb-fano-test-result/netgauze/netgauze-yangpush-publisher to obtain the YANG-Push notification packet capture for FANO.

https://github.com/network-analytics/ietf-network-analytics-document-status/tree/main/126/Hackathon/mb-alive-test-result/netgauze/netgauze-yangpush-publisher to obtain the YANG-Push notification packet capture for ALIVE.

https://github.com/network-analytics/ietf-network-analytics-document-status/tree/main/126/Hackathon/mb-titan-test-result/netgauze/netgauze-yangpush-publisher to obtain the YANG-Push notification packet capture for TITAN.

Use [traffic-reproducer](https://github.com/network-analytics/traffic-reproducer) to replay the Swisscom provided packet capture towards the running NetGauze YANG-Push Receiver. You are however free to use any other tool you prefer (e.g. `tcpreplay`).

`traffic-reproducer` is a Scapy-based Python tool that replays PCAP files towards a collector while simulating original inter-packet timing and supporting multiple source IPs.

#### 3.1 Install traffic-reproducer

For installation instructions, please refer to the [official README](https://github.com/network-analytics/traffic-reproducer/blob/master/README.md).

#### 3.2 Create a traffic-reproducer Configuration

Create a file called `repro-config.yaml`. The key items to configure are:
- The path to the PCAP file
- The IP mapping from original PCAP source IPs to your local reproduced IPs
- The YANG-Push Receiver destination (where NetGauze is listening)

> **Tip:** Use Wireshark or `tshark` to inspect the PCAP file and identify the source IPs and UDP destination port you will need for the configuration below.

```yaml
pcap:
  - <PATH_TO_PCAP>               # e.g. /home/user/lab/lab-assets/traffic.pcap

time_factor: 1.0                 # 1.0 = real-time; lower values replay faster (e.g. 0.5 = 2x speed)
keep_open: false
no_sync: true                    # UDP-Notif does not require minute-boundary synchronisation

network:
  map:
    # For each source IP present in the PCAP, map it to a local IP that will be used for replay.
    # Add one entry per unique source device in the PCAP.
    - src_ip: <ORIGINAL_SOURCE_IP_IN_PCAP>
      repro_ip: <LOCAL_REPLAY_IP>
    # - src_ip: <ANOTHER_SOURCE_IP>
    #   repro_ip: <ANOTHER_LOCAL_IP>

  interface: null                # Set to a specific interface name if needed (e.g. "eth0")

udp_generic:
  select:
    udp:
      dport:
        - <ORIGINAL_DPORT_IN_PCAP>   # The UDP destination port used in the PCAP
  collector:
    ip: <NETGAUZE_COLLECTOR_IP>      # IP of the host running NetGauze
    port: <UDP_NOTIF_PORT>           # Must match the listener port in config-lab.yaml
```

#### 3.3 Replay the Packet Capture

```bash
python main.py -v --cfg repro-config.yaml
```

For full usage instructions and available options, refer to the [official README](https://github.com/network-analytics/traffic-reproducer/blob/master/README.md).

---

### Step 4 – Reproduce Telemetery Mockup Messages

Install kcat https://github.com/edenhill/kcat. In https://github.com/network-analytics/ietf-network-analytics-document-status/tree/main/126/Hackathon/mb-test-cases you will find test json Network Telemetry messages which are from a YANG schema validation perspective invalid, and commands how to simulate a YANG Message Broker Producer.

---

### Step 5 – Consume Messages from Apache Kafka

At this point, YANG Push messages are to the configured Apache Kafka topic as **JSON payloads**. Each message carries a **schema ID in its header** that identifies the YANG schema used; that schema can be fetched from the YANG Schema Registry at the URL you configured.

Your consumer should:

1. **Read messages** from the Apache Kafka topic configured in Step 2 (e.g. `telemetry-message-yang`).
2. **Extract the schema ID** from the Apache Kafka message header.
3. **Resolve the schema** by querying the YANG Schema Registry (the same endpoint configured in `schema_registry_url`).
4. **Validate the JSON payload** according to the resolved YANG schema tree.

For details on the message header format and schema resolution API, refer to the [schema-registry](https://github.com/confluentinc/schema-registry) documentation.