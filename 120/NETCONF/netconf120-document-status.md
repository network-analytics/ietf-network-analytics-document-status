## NETCONF Working Group

IETF 119 Meeting minutes
https://notes.ietf.org/notes-ietf-119-netconf#

IETF 119 Meeting session
https://datatracker.ietf.org/meeting/119/session/netconf

### draft-ietf-netconf-udp-notif
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-netconf-udp-notif/
* **State**: Presented -12 at NETCONF 119, draft-ahuang-netconf-udp-client-server-grouping dependency, feedback tracked in issue 13 and addressed in -13. -14 rollbacked based on Med feedback the default port.
* **Tasks**: https://github.com/network-analytics/draft-ietf-netconf-udp-notif/issues/13
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-ietf-netconf-udp-notif
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-netconf-udp-notif-13&url_2=https://raw.githubusercontent.com/network-analytics/draft-ietf-netconf-udp-notif/main/draft-ietf-netconf-udp-notif-14.txt

### draft-ietf-netconf-udp-client-server
* **URL**: https://datatracker.ietf.org/doc/draft-ahuang-netconf-udp-client-server/
* **State**: Presented -01 at NETCONF 119. Adopted in working group, feedback tracked in issue 2 and addressed in -02. -03 published with changes on default port.
* **Tasks**: https://mailarchive.ietf.org/arch/msg/netconf/j-2Hh6PO-QcHZetZ0ebujxsVLL0/, 
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-ietf-netconf-udp-client-server
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-netconf-udp-client-server-02&doc_2=draft-ietf-netconf-udp-client-server-03

### draft-ietf-netconf-distributed-notif
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-netconf-distributed-notif/
* **State**: Presented -08 at NETCONF 118, requested working group last call together with draft-ietf-netconf-udp-notif, added message-publisher-id in push-update and push-change-update and added 6WIND in implementation status section. Removed "ordered-by user" on message-publisher-id leaf-list and updated descriptions. Published -09 and requested feedback from working group.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-ietf-netconf-distributed-notif
* **Diff**: https://author-tools.ietf.org/iddiff?url1=draft-ietf-netconf-distributed-notif-08&url2=draft-ietf-netconf-distributed-notif-09&difftype=--html

### draft-ahuang-netconf-notif-yang
* **URL**: https://datatracker.ietf.org/doc/draft-ahuang-netconf-notif-yang/
* **State**: Presented -04 at NETCONF 119, document will be fast tracked due to gap within RFC 8639 and RFC 8641 specification, adoption call received push back. Pushback addressed in -05.
* **Tasks**: Draft should update RFC 5277, RFC 8639 and RFC 7951 instead of RFC 5277 only since updating RFC 5277 impacts RFC 8639 and RFC 7951, new section should describe relationship to RFC 5277, RFC 8639 and RFC 7951 like https://datatracker.ietf.org/doc/html/rfc8639#section-1.4, scope should exclude Restconf RFC 8040 since https://datatracker.ietf.org/doc/html/rfc8040#section-6 already describes how notifications in Restconf with JSON is defined. -05 published and feedback received from Med.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-ahuang-netconf-notif-yang
* **Adoption Call Blocker**: https://mailarchive.ietf.org/arch/msg/netconf/Q4S-qPV323F-1KsCSVNf5W1ungc/
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ahuang-netconf-notif-yang-04&url_2=https://raw.githubusercontent.com/network-analytics/draft-ahuang-netconf-notif-yang/master/draft-ahuang-netconf-notif-yang-05.txt

### draft-ietf-netconf-yang-notifications-versioning
* **URL**: https://datatracker.ietf.org/doc/draft-ietf-netconf-yang-notifications-versioning/
* **State**: Presented -03 at NETCONF 118, resolved issue that within  a "case" statement identifiers need to be unique. -05 published.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-ietf-netconf-yang-notifications-versioning
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-ietf-netconf-yang-notifications-versioning-04&doc_2=draft-ietf-netconf-yang-notifications-versioning-05

### draft-tgraf-netconf-notif-sequencing
* **URL**: https://datatracker.ietf.org/doc/draft-tgraf-netconf-notif-sequencing/
* **State**: Presented -02 at NETCONF 118, requested working group adoption. Have you read the notif-sequencing draft? YES: 6, NO: 13, ?: 38. 
* **Tasks**: Defined new notification capability and describe RFC 9196 discovery mechanism how a system detects that a YANG-Push publisher supports draft-tgraf-netconf-notif-sequencing in -06.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-tgraf-netconf-notif-sequencing
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-tgraf-netconf-notif-sequencing-04&doc_2=draft-tgraf-netconf-notif-sequencing-06

### draft-tgraf-netconf-yang-push-observation-time
* **URL**: https://datatracker.ietf.org/doc/draft-tgraf-netconf-yang-push-observation-time/
* **State**: Presented -00 at NETCONF 116, added implementation status and operational consideration section, changed observation time semantics in -02.
* **Mailinglist**: https://mailarchive.ietf.org/arch/browse/netconf/?q=draft-tgraf-netconf-yang-push-observation-time
* **Diff**: https://author-tools.ietf.org/diff?doc_1=draft-tgraf-netconf-yang-push-observation-time-01&url_2=https://raw.githubusercontent.com/network-analytics/draft-tgraf-netconf-yang-push-observation-time/main/draft-tgraf-netconf-yang-push-observation-time-02.txt