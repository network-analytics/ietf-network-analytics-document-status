## NMOP Working Group

IETF 125 Meeting minutes
https://notes.ietf.org/notes-ietf-125-nmop#

IETF 125 Meeting session
https://datatracker.ietf.org/meeting/125/session/nmop

### draft-ietf-nmop-yang-message-broker-integration
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-yang-message-broker-integration/
* **State**: Presented -05 at NMOP 121, merged input from Paul Aitken and some editorial cleanup in-08, replaced syname with hostname and RabitMQ with Apache Pulsar and added streaming catalog in -09. Merged input from Reshad in -10. Requires review and updates in -12 based on Reshad's feedback and operational and security considerations. Added YANG deviations in schema registry in -13.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-yang-message-broker-integration
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-yang-message-broker-integration-12&url_2=https://raw.githubusercontent.com/network-analytics/draft-ietf-nmop-yang-message-broker-integration/refs/heads/main/draft-ietf-nmop-yang-message-broker-integration-13.txt

### draft-ietf-message-broker-telemetry-message
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-message-broker-telemetry-message/
* **State**: Presenting -00 at NMOP 122, initial version, received feedback from Alex and Rob. Use platform-details grouping from ietf-platform-manifest and clarify with ietf-platform-manifest authors leaf meaning. Merge input from adoption call in -01. Merged input from Reshad in -02. Merged input from Rob on changing leaf and module grouping names in -02. Replaced RabitMQ with Apache Pulsar and addressed YANG doctors review in -03. Merged input from Paolo and updated implementation status section in -04.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-message-broker-telemetry-message
* **Diff**: https://author-tools.ietf.org/iddiff?url2=draft-ietf-nmop-message-broker-telemetry-message-04

### draft-ietf-nmop-yang-message-broker-message-key
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-yang-message-broker-message-key/
* **State**: Initial publication with -00 with merged input from Alex. Merged input from Benoit in -01 and input from Hellmar in -02. Adressed nits from Reshad in -03. Adressing adoption call input from Rob, Olga and Michael in -04. Merged input from Ahmed in -02.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-yang-message-broker-message-key
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-yang-message-broker-message-key-01&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-yang-message-broker-message-key/refs/heads/main/draft-ietf-nmop-yang-message-broker-message-key-02.txt

### draft-netana-nmop-message-broker-bmp-telemetry-msg
* **URL**: https://datatracker.ietf.org/doc/draft-netana-nmop-message-broker-bmp-telemetry-msg/
* **State**: Presented -02 at IETF 125, refactor by importing ietf-bgp instead of redefining submodules, and add cababilities support to peer-up, add tlvs from RFC7854, RFC6069, draft-ietf-grow-bmp-path-marking-tlv, and draft-ietf-grow-bmp-tlv, add bgp open fields, refactor on message key and topic name to accommodate message ordering for -03.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-netana-nmop-message-broker-bmp-telemetry-msg
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-netana-nmop-message-broker-bmp-telemetry-msg-02&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-message-broker-bmp-telemetry-message/refs/heads/main/draft-netana-nmop-message-broker-bmp-telemetry-msg-03.txt

### draft-ietf-nmop-network-anomaly-architecture
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-network-anomaly-architecture/
* **State**: Presented -01 at IETF 121, merged input from Qin and Nacho, merged input from Adrian on terminology and Alex on editorial changes in -02. Replaced cause with trigger and add templates in patterns in -03 and changed Service Model reference from RFC 8309 to RFC8969 and merged input from Rüdiger and Reshad in -04. Merged editorial input from Paul and Reshad in -05. Merged input from Ruediger in -06 and -07. Moved SIMAP and Knowledge Graph references to informative in -08.
* **Tasks**: Add description Apache Iceberg integration
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-network-anomaly-architecture
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-network-anomaly-architecture-07&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-network-anomaly-architecture/refs/heads/main/draft-ietf-nmop-network-anomaly-architecture-08.txt

### draft-ietf-nmop-network-anomaly-semantics
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-network-anomaly-semantics/
* **State**: Presented -02 at NMOP 122. Merged terminology input from Adrian (https://mailarchive.ietf.org/arch/msg/nmop/ufL-6RdA09pR7gzxHaNtSb-a-54/), Updated YANG modules. Added "template" and "season" into ietf-network-anomaly-symptom-cbl and maintenance related information into ietf-network-anomaly-service-topology, Added in Section 4.4 Apache AVRO data model translation, Completed Security Considerations with draft-ietf-netmod-rfc8407bis-22#appendix-B, Added normative reference to Service Model, RFC 8969 and descried service model context, Added Cosmos Bright Lights in Implementation status section. Added vpn-network-termination grouping in -04. Merged input from Ruediger in -05. Merged input from Reshad in -06.
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/ft0ifhrd6h6J47qXOgSoFWVKpoI/
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-network-anomaly-semantics
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-network-anomaly-semantics-05&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-network-anomaly-semantics/refs/heads/main/draft-ietf-nmop-network-anomaly-semantics-06.txt

### draft-ietf-nmop-network-anomaly-lifecycle
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-nmop-network-anomaly-lifecycle/
* **State**: Presented -02 at NMOP 122, Updated relevant-state YANG module with global uri, confidence-score, strategy and added anomalies container, Completed Security Considerations with draft-ietf-netmod-rfc8407bis-22#appendix-B, Merged terminology input from Adrian, merged terminology input from Adrian. Addressed some of the comments from Reshad and Paul in -04. Refined Confidence and Concern Score definitions and some minor YANG model fixes in -05. Adressing Reshad's comments in -06.
* **Tasks**: https://mailarchive.ietf.org/arch/msg/nmop/CWWGhCADia4YAhSaeDmrbyEnKC0/
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/nmop/?q=draft-ietf-nmop-network-anomaly-lifecycle
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-nmop-network-anomaly-lifecycle-05&url_2=https://raw.githubusercontent.com/network-analytics/draft-netana-nmop-network-anomaly-lifecycle/refs/heads/main/draft-ietf-nmop-network-anomaly-lifecycle-06.txt