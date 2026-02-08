### YANG Message Broker Consumer
As described in https://datatracker.ietf.org/doc/html/draft-ietf-nmop-yang-message-broker-integration-10#section-4.7

```


      +------------------------------------------------------------+
      |                     YANG Data Storage                      |
      +------------------------------------------------------------+
                                     ^
                                     | (12) Ingest Data
                                     | According to Schema
      +------------------------------------------------------------+
      |                    YANG Data Consumer                      |
      +------------------------------------------------------------+
      |               YANG Message Broker Consumer                 |
      +------------------------------------------------------------+
            |  ^                                   ^
   (10) Get |  |                                   | (9) Validate
     Schema |  |                                   | Serialized Message
            |  |                                   | Schema on Consumer
            |  |                              +--------------------+
            |  |                              |      Message       |
            |  |                              |      Broker        |
            |  |                              +--------------------+
            |  |                                   ^
            |  |                                   | (8) Serialize
            |  |                                   | YANG-Push Message
            |  |                                   | annotated Schema
            |  |                                   | ID on Producer
            |  |                                   |
            |  |                                   |
            |  | (11) Issue                   +--------------------+
            |  |      Schema                  |    YANG Message    |
            v  |                  (6) Post    |   Broker Consumer  |
      +--------------------+          Schema  +--------------------+
      |       YANG         | <--------------- |  Data Collection   |
      |  Schema Registry   | ---------------> | YANG-Push Receiver |
      +--------------------+  (7) Issue       +--------------------+
            |                     Schema ID        |  ^ (3) Receive
            |                                      |  | YANG-Push
            v                         (4) Discover |  | Subscription
      +--------------------+                Schema |  | Start Message
      |      Stream        |          Dependencies |  |   ^
      |      Catalog       |            and Obtain |  |   | (5) Publish
      +--------------------+               Schemas |  |   | YANG-Push
                                                   |  |   | Message
                                                   |  |   | with
                             (1) Discover          |  |   | Subscriber
                                 Notification      v  |   | ID
      +--------------------+     Capabilities +--------------------+
      |  Manage YANG-Push  | ---------------> |   Network Node     |
      |    Subscription    | ---------------> | YANG-Push Publisher|
      +--------------------+ (2) Subscribe    +--------------------+

Figure 1: End to End Workflow

```