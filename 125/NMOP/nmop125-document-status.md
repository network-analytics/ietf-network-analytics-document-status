## NMOP Working Group

IETF 124 Meeting minutes
https://notes.ietf.org/notes-ietf-124-nmop#

IETF 124 Meeting session
https://datatracker.ietf.org/meeting/124/session/nmop

### draft-ietf-nmop-yang-message-broker-integration
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-yang-message-broker-integration/
* **State**: Presented -05 at NMOP 121, merged input from Paul Aitken and some editorial cleanup in-08, replaced syname with hostname and RabitMQ with Apache Pulsar and added streaming catalog in -09. Merged input from Reshad in -10.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-yang-message-broker-integration
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-yang-message-broker-integration-09&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-yang-kafka-integration/refs/heads/main/draft-ietf-nmop-yang-message-broker-integration-10.txt

### draft-ietf-message-broker-telemetry-message
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-message-broker-telemetry-message/
* **State**: Presenting -00 at NMOP 122, initial version, received feedback from Alex and Rob. Use platform-details grouping from ietf-platform-manifest and clarify with ietf-platform-manifest authors leaf meaning. Merge input from adoption call in -01. Merged input from Reshad in -02. Merged input from Rob on changing leaf and module grouping names in -02. Replaced RabitMQ with Apache Pulsar and addressed YANG doctors review in -03. Merged input from Paolo and updated implementation status section in -04.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-message-broker-telemetry-message
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-message-broker-telemetry-message-03&url_2=https://raw.githubusercontent.com/network-analytics/draft-ietf-message-broker-telemetry-message/refs/heads/main/draft-ietf-nmop-message-broker-telemetry-message-04.txt

### draft-netana-nmop-yang-message-broker-message-key
* **URL**: https://datatracker.ietf.org/doc/draft-netana-nmop-yang-message-broker-message-key/
* **State**: Initial publication with -00 with merged input from Alex. Merged input from Benoit in -01. Ahmed pending.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-message-broker-telemetry-message
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-netana-nmop-yang-message-broker-message-key-01&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-yang-message-broker-message-key/refs/heads/main/draft-netana-nmop-yang-message-broker-message-key-02.txt

### draft-ietf-nmop-network-anomaly-architecture
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-network-anomaly-architecture/
* **State**: Presented -01 at IETF 121, merged input from Qin and Nacho, merged input from Adrian on terminology and Alex on editorial changes in -02. Replaced cause with trigger and add templates in patterns in -03 and changed Service Model reference from RFC 8309 to RFC8969 and merged input from Rüdiger and Reshad in -04. Merged editorial input from Paul and Reshad in -05. Merged input from Ruediger in -06 and -07.
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/Qb2w6ABl6i5fd5N0g5hVIT_YVmo/
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/dj1XlB4KNiK090t0fnxQibTJxXo/
* **Tasks**: Add description Apache Iceberg integration
* **Tasks**: https://github.com/network-analytics/draft-netana-nmop-network-anomaly-architecture/issues/4
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-network-anomaly-architecture
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-network-anomaly-architecture-06&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-network-anomaly-architecture/refs/heads/main/draft-ietf-nmop-network-anomaly-architecture-07.txt

### draft-ietf-nmop-network-anomaly-semantics
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-network-anomaly-semantics/
* **State**: Presented -02 at NMOP 122. Merged terminology input from Adrian (https://mailarchive.ietf.org/arch/msg/nmop/ufL-6RdA09pR7gzxHaNtSb-a-54/), Updated YANG modules. Added "template" and "season" into ietf-network-anomaly-symptom-cbl and maintenance related information into ietf-network-anomaly-service-topology, Added in Section 4.4 Apache AVRO data model translation, Completed Security Considerations with draft-ietf-netmod-rfc8407bis-22#appendix-B, Added normative reference to Service Model, RFC 8969 and descried service model context, Added Cosmos Bright Lights in Implementation status section. Added vpn-network-termination grouping in -04.
* **Tasks**: https://notes.ietf.org/notes-ietf-123-nmop#3-Anomaly-semantics-and-lifecycle-10-min
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/Qb2w6ABl6i5fd5N0g5hVIT_YVmo/
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-network-anomaly-semantics
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-network-anomaly-semantics-03&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-network-anomaly-semantics/refs/heads/main/draft-ietf-nmop-network-anomaly-semantics-04.txt

### draft-ietf-nmop-network-anomaly-lifecycle
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-network-anomaly-lifecycle/
* **State**: Presented -02 at NMOP 122, Updated relevant-state YANG module with global uri, confidence-score, strategy and added anomalies container, Completed Security Considerations with draft-ietf-netmod-rfc8407bis-22#appendix-B, Merged terminology input from Adrian, merged terminology input from Adrian. Addressed some of the comments from Reshad and Paul in -04, work in progress.
* **Tasks**: https://notes.ietf.org/notes-ietf-123-nmop#3-Anomaly-semantics-and-lifecycle-10-min
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/Qb2w6ABl6i5fd5N0g5hVIT_YVmo/
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/3OUH3Hagi_2WRITaj833oqIOWfw/
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-network-anomaly-lifecycle
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-network-anomaly-lifecycle-04&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-network-anomaly-lifecycle/refs/heads/main/draft-ietf-nmop-network-anomaly-lifecycle-05.txt