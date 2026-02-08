## 4. YANG Message Broker Consumer - YANG Schema Collection

With the consumption of YANG Network Telemetry messages the schema id at the top of the YANG schema tree is being learned. The YANG schema and YANG feature metadata with all their related YANG schemas and YANG feature metadatas are being obtained and cached locally.

### 4.1 NetGauze Implementation

In `/opt/NetGauze-bin/kafka-yang-consumer-cache/` for each YANG schema id a dedicated folder is dynamically created when the YANG Message Broker Consumer `/opt/NetGauze-bin/kafka-yang-consumer` is consuming from topic. Within the subdirectory modules all YANG schema registry obtained YANG modules are stored and with `yang-lib.xml` a YANG library context is being generated automatically. The `subscription-info.json` can be ignored for the moment. Below an example for YANG schema id 527.

```
root@daisy-playground-rh8 [ /opt/NetGauze-bin/kafka-yang-consumer-cache ] () # cd schema-id-527
modules  subscriptions-info.json  yang-lib.xml
root@daisy-playground-rh8 [ /opt/NetGauze-bin/kafka-yang-consumer-cache/schema-id-527 ] () # ll
total 104K
drwxr-xr-x  3 root     root       72 Feb  3 11:02 .
drwxr-xr-x 23 taarole8 taarole8 4.0K Feb  3 13:38 ..
drwxr-xr-x  2 root     root      24K Feb  3 11:02 modules
-rw-r--r--  1 root     root      214 Feb  3 11:02 subscriptions-info.json
-rw-r--r--  1 root     root      65K Feb  3 11:02 yang-lib.xml
```


## 5. YANG Message Broker Consumer - YANG Schema Tree Generation

With the previously obtained YANG schemas a YANG schema tree is being generated for message schema validation.


### 5.1 NetGauze Implementation

With below yanglint validation command the YANG module from the YANG-Push xpath subscription (xpath is ietf-alarms:alarm-notification in this example) and the ietf-telemetry-message YANG module with the YANG structure reference is used to build the YANG schema tree.

```
root@daisy-playground-rh8 [ /opt/NetGauze-bin/kafka-yang-consumer-cache/schema-id-527 ] () # yanglint -f tree ietf-alarms@2019-09-11.yang ietf-telemetry-message@2025-10-19.yang -Y yang-lib.xml -p modules -t ext -k  ietf-telemetry-message:structure:message
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xponani-ani-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xponani-v-enet-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpongemtcont-traffic-descriptor-profile-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpongemtcont-tcont-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpongemtcont-tcont-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpongemtcont-gemport-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpongemtcont-gemport-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xponvani-v-ani-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-wavelength-profile-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-multicast-gemport-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-group-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-group-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-partition-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-pair-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-pair-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-pair-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-channel-termination-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-multicast-distribution-set-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xpon-multicast-distribution-set-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-xponvani-v-enet-body) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-flooding-policies) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-flooding-policies) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-forwarders) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-forwarding-databases) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-forwarding-databases) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-mac-learning) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-mac-learning) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-mac-learning) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-split-horizon-profiles) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-split-horizon-profiles) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-mac-learning-control) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-mac-learning-control) are not necessary.
libyang warn: YANG version 1.1 expects all includes in main module, includes in submodules (bbf-l2-forwarding-mac-learning-control) are not necessary.
libyang warn: Identityref "bridge-type" comparison with identity "two-port-mac-relay-bridge" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[6] "bridge-type != 'two-port-mac-relay-bridge'" with context node "/ieee802-dot1q-bridge:bridges/bridge/component/bridge-mst".
libyang warn: Identityref "bridge-type" comparison with identity "two-port-mac-relay-bridge" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[6] "bridge-type != 'two-port-mac-relay-bridge'" with context node "/ieee802-dot1q-bridge:bridges/bridge/component/bridge-vlan".
libyang warn: Identityref "bridge-type" comparison with identity "two-port-mac-relay-bridge" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[6] "bridge-type != 'two-port-mac-relay-bridge'" with context node "/ieee802-dot1q-bridge:bridges/bridge/component/filtering-database".
libyang warn: Identityref "packet-type" comparison with identity "igmp" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[3] "packet-type = 'igmp'" with context node "/bbf-xpon:xpon/bbf-uni-profile:uni-profiles/uni-profile/packet-forwards/packet-forward/forward/user-vlan/user-vlan".
libyang warn: Identityref "packet-type" comparison with identity "multicast" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[3] "packet-type = 'multicast'" with context node "/bbf-xpon:xpon/bbf-uni-profile:uni-profiles/uni-profile/packet-forwards/packet-forward/forward/vlan-tagged/vlan-type/igmp-user-vlan/igmp-user-vlan".
libyang warn: Identityref "packet-type" comparison with identity "igmp" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[3] "packet-type = 'igmp'" with context node "/bbf-xpon:xpon/bbf-uni-profile:uni-profiles/uni-profile/packet-forwards/packet-forward/forward/vlan-tagged/priority".
libyang warn: Identityref "packet-type" comparison with identity "igmp" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[3] "packet-type = 'igmp'" with context node "/bbf-xpon:xpon/bbf-uni-profile:uni-profiles/uni-profile/packet-forwards/packet-forward/forward/vlan-tagged/tagged-mode".
libyang warn: Identityref "packet-type" comparison with identity "multicast" without prefix, consider adding a prefix or best using "derived-from(-or-self)()" functions.
libyang warn: Previous warning generated by XPath subexpression[3] "packet-type = 'multicast'" with context node "/bbf-xpon:xpon/bbf-uni-profile:uni-profiles/uni-profile/packet-forwards/packet-forward/forward/untagged/untagged".
libyang warn: Invalid value "0" which does not fit the type (Invalid bit "0".).
libyang warn: Previous warning generated by XPath subexpression[8] ") != 0" with context node "/huawei-ssl:ssl/tlcp-policys/tlcp-policy/cipher-suites".
module: ietf-alarms
  +--rw alarms
     +--rw control
     |  +--rw max-alarm-status-changes?   union
     |  +--rw notify-status-changes?      enumeration
     |  +--rw notify-severity-level?      severity
     |  +--rw alarm-shelving {alarm-shelving}?
     |  |  +--rw shelf* [name]
     |  |  |  +--rw name                    string
     |  |  |  +--rw resource*               resource-match
     |  |  |  +--rw alarm-type* [alarm-type-id alarm-type-qualifier-match]
     |  |  |  |  +--rw alarm-type-id                 alarm-type-id
     |  |  |  |  +--rw alarm-type-qualifier-match    string
     |  |  |  +--rw description?            string
     |  |  |  +--rw an-alm:severity?        al:severity
     |  |  |  +--rw ccsa-an-alm:severity?   al:severity
     |  |  +--rw an-alm:alarm-shelving-enabled?        boolean
     |  |  +--rw ccsa-an-alm:alarm-shelving-enabled?   boolean
     |  +--rw x733:x733-mapping* [alarm-type-id alarm-type-qualifier-match] {configure-x733-mapping}?
     |     +--rw x733:alarm-type-id                 al:alarm-type-id
     |     +--rw x733:alarm-type-qualifier-match    string
     |     +--rw x733:event-type?                   event-type
     |     +--rw x733:probable-cause?               uint32
     |     +--rw x733:probable-cause-string?        string
     +--ro alarm-inventory
     |  +--ro alarm-type* [alarm-type-id alarm-type-qualifier]
     |     +--ro alarm-type-id                 alarm-type-id
     |     +--ro alarm-type-qualifier          alarm-type-qualifier
     |     +--ro resource*                     resource-match
     |     +--ro will-clear                    boolean
     |     +--ro severity-level*               severity
     |     +--ro description                   string
     |     +--ro hw-alarm-ext:alarm-id?        uint32
     |     +--ro hw-alarm-ext:object-type?     object-type
     |     +--ro hw-alarm-ext:alarm-name?      string
     |     +--ro hw-alarm-ext:alarm-class?     alarm-class
     |     +--ro hw-alarm-ext:default-level?   al:severity
     |     +--ro hw-alarm-ext:convert-flag?    convert-flag
     |     +--ro hw-alarm-ext:alarm-effect?    hw-alarm-ext:effect-type
     |     +--ro x733:event-type?              event-type
     |     +--ro x733:probable-cause?          uint32
     |     +--ro x733:probable-cause-string?   string
     +--ro alarm-list
     |  +--ro number-of-alarms?   yang:gauge32
     |  +--ro last-changed?       yang:date-and-time
     |  +--ro alarm* [resource alarm-type-id alarm-type-qualifier]
     |  |  +--ro resource                              resource
     |  |  +--ro alarm-type-id                         alarm-type-id
     |  |  +--ro alarm-type-qualifier                  alarm-type-qualifier
     |  |  +--ro alt-resource*                         resource
     |  |  +--ro related-alarm* [resource alarm-type-id alarm-type-qualifier] {alarm-correlation}?
     |  |  |  +--ro resource                -> /alarms/alarm-list/alarm/resource
     |  |  |  +--ro alarm-type-id           -> /alarms/alarm-list/alarm[resource=current()/../resource]/alarm-type-id
     |  |  |  +--ro alarm-type-qualifier    -> /alarms/alarm-list/alarm[resource=current()/../resource][alarm-type-id=current()/../alarm-type-id]/alarm-type-qualifier
     |  |  +--ro impacted-resource*                    resource {service-impact-analysis}?
     |  |  +--ro root-cause-resource*                  resource {root-cause-analysis}?
     |  |  +--ro time-created                          yang:date-and-time
     |  |  +--ro is-cleared                            boolean
     |  |  +--ro last-raised                           yang:date-and-time
     |  |  +--ro last-changed                          yang:date-and-time
     |  |  +--ro perceived-severity                    severity
     |  |  +--ro alarm-text                            alarm-text
     |  |  +--ro status-change* [time] {alarm-history}?
     |  |  |  +--ro time                  yang:date-and-time
     |  |  |  +--ro perceived-severity    severity-with-clear
     |  |  |  +--ro alarm-text            alarm-text
     |  |  +--ro operator-state-change* [time] {operator-actions}?
     |  |  |  +--ro time        yang:date-and-time
     |  |  |  +--ro operator    string
     |  |  |  +--ro state       operator-state
     |  |  |  +--ro text?       string
     |  |  +--ro an-alm:notification-serial-id?        yang:gauge32
     |  |  +--ro an-alm:alarm-name?                    string
     |  |  +--ro ccsa-an-alm:notification-serial-id?   yang:gauge32
     |  |  +--ro ccsa-an-alm:alarm-name?               string
     |  |  +--ro x733:event-type?                      event-type
     |  |  +--ro x733:probable-cause?                  uint32
     |  |  +--ro x733:probable-cause-string?           string
     |  |  +--ro x733:threshold-information
     |  |  |  +--ro x733:triggered-threshold?   string
     |  |  |  +--ro x733:observed-value?        value-type
     |  |  |  +--ro (x733:threshold-level)?
     |  |  |  |  +--:(x733:up)
     |  |  |  |  |  +--ro x733:up-high?   value-type
     |  |  |  |  |  +--ro x733:up-low?    value-type
     |  |  |  |  +--:(x733:down)
     |  |  |  |     +--ro x733:down-low?    value-type
     |  |  |  |     +--ro x733:down-high?   value-type
     |  |  |  +--ro x733:arm-time?              yang:date-and-time
     |  |  +--ro x733:monitored-attributes* [id]
     |  |  |  +--ro x733:id       al:resource
     |  |  |  +--ro x733:value?   string
     |  |  +--ro x733:proposed-repair-actions*         string
     |  |  +--ro x733:trend-indication?                trend
     |  |  +--ro x733:backedup-status?                 boolean
     |  |  +--ro x733:backup-object?                   al:resource
     |  |  +--ro x733:additional-information* [identifier]
     |  |  |  +--ro x733:identifier     string
     |  |  |  +--ro x733:significant?   boolean
     |  |  |  +--ro x733:information?   string
     |  |  +--ro x733:security-alarm-detector?         al:resource
     |  |  +--ro x733:service-user?                    al:resource
     |  |  +--ro x733:service-provider?                al:resource
     |  |  +---x set-operator-state {operator-actions}?
     |  |  |  +---w input
     |  |  |     +---w state    writable-operator-state
     |  |  |     +---w text?    string
     |  |  +---n operator-action {operator-actions}?
     |  |     +---- time        yang:date-and-time
     |  |     +---- operator    string
     |  |     +---- state       operator-state
     |  |     +---- text?       string
     |  +---x purge-alarms
     |  |  +---w input
     |  |  |  +---w alarm-clearance-status?               enumeration
     |  |  |  +---w older-than!
     |  |  |  |  +---w (age-spec)?
     |  |  |  |     +--:(seconds)
     |  |  |  |     |  +---w seconds?   uint16
     |  |  |  |     +--:(minutes)
     |  |  |  |     |  +---w minutes?   uint16
     |  |  |  |     +--:(hours)
     |  |  |  |     |  +---w hours?   uint16
     |  |  |  |     +--:(days)
     |  |  |  |     |  +---w days?   uint16
     |  |  |  |     +--:(weeks)
     |  |  |  |        +---w weeks?   uint16
     |  |  |  +---w severity!
     |  |  |  |  +---w (sev-spec)?
     |  |  |  |     +--:(below)
     |  |  |  |     |  +---w below?   severity
     |  |  |  |     +--:(is)
     |  |  |  |     |  +---w is?   severity
     |  |  |  |     +--:(above)
     |  |  |  |        +---w above?   severity
     |  |  |  +---w operator-state-filter! {operator-actions}?
     |  |  |  |  +---w state?   operator-state
     |  |  |  |  +---w user?    string
     |  |  |  +---w an-alm:notification-serial-id?        yang:gauge32
     |  |  |  +---w ccsa-an-alm:notification-serial-id?   yang:gauge32
     |  |  |  +---w hw-alarm-ext:serial-id*               uint32
     |  |  |  +---w hw-alarm-ext:alarm-id?                uint32
     |  |  |  +---w hw-alarm-ext:alarm-parameter?         string
     |  |  |  +---w hw-alarm-ext:all?                     empty
     |  |  +--ro output
     |  |     +--ro purged-alarms?   uint32
     |  +---x compress-alarms {alarm-history}?
     |     +---w input
     |     |  +---w resource?               resource-match
     |     |  +---w alarm-type-id?          -> /alarms/alarm-list/alarm/alarm-type-id
     |     |  +---w alarm-type-qualifier?   -> /alarms/alarm-list/alarm/alarm-type-qualifier
     |     +--ro output
     |        +--ro compressed-alarms?   uint32
     +--ro shelved-alarms {alarm-shelving}?
     |  +--ro number-of-shelved-alarms?      yang:gauge32
     |  +--ro shelved-alarms-last-changed?   yang:date-and-time
     |  +--ro shelved-alarm* [resource alarm-type-id alarm-type-qualifier]
     |  |  +--ro resource                        resource
     |  |  +--ro alarm-type-id                   alarm-type-id
     |  |  +--ro alarm-type-qualifier            alarm-type-qualifier
     |  |  +--ro alt-resource*                   resource
     |  |  +--ro related-alarm* [resource alarm-type-id alarm-type-qualifier] {alarm-correlation}?
     |  |  |  +--ro resource                -> /alarms/alarm-list/alarm/resource
     |  |  |  +--ro alarm-type-id           -> /alarms/alarm-list/alarm[resource=current()/../resource]/alarm-type-id
     |  |  |  +--ro alarm-type-qualifier    -> /alarms/alarm-list/alarm[resource=current()/../resource][alarm-type-id=current()/../alarm-type-id]/alarm-type-qualifier
     |  |  +--ro impacted-resource*              resource {service-impact-analysis}?
     |  |  +--ro root-cause-resource*            resource {root-cause-analysis}?
     |  |  +--ro shelf-name?                     -> /alarms/control/alarm-shelving/shelf/name
     |  |  +--ro is-cleared                      boolean
     |  |  +--ro last-raised                     yang:date-and-time
     |  |  +--ro last-changed                    yang:date-and-time
     |  |  +--ro perceived-severity              severity
     |  |  +--ro alarm-text                      alarm-text
     |  |  +--ro status-change* [time] {alarm-history}?
     |  |  |  +--ro time                  yang:date-and-time
     |  |  |  +--ro perceived-severity    severity-with-clear
     |  |  |  +--ro alarm-text            alarm-text
     |  |  +--ro operator-state-change* [time] {operator-actions}?
     |  |  |  +--ro time        yang:date-and-time
     |  |  |  +--ro operator    string
     |  |  |  +--ro state       operator-state
     |  |  |  +--ro text?       string
     |  |  +--ro an-alm:alarm-name?              string
     |  |  +--ro ccsa-an-alm:alarm-name?         string
     |  |  +--ro x733:event-type?                event-type
     |  |  +--ro x733:probable-cause?            uint32
     |  |  +--ro x733:probable-cause-string?     string
     |  |  +--ro x733:threshold-information
     |  |  |  +--ro x733:triggered-threshold?   string
     |  |  |  +--ro x733:observed-value?        value-type
     |  |  |  +--ro (x733:threshold-level)?
     |  |  |  |  +--:(x733:up)
     |  |  |  |  |  +--ro x733:up-high?   value-type
     |  |  |  |  |  +--ro x733:up-low?    value-type
     |  |  |  |  +--:(x733:down)
     |  |  |  |     +--ro x733:down-low?    value-type
     |  |  |  |     +--ro x733:down-high?   value-type
     |  |  |  +--ro x733:arm-time?              yang:date-and-time
     |  |  +--ro x733:monitored-attributes* [id]
     |  |  |  +--ro x733:id       al:resource
     |  |  |  +--ro x733:value?   string
     |  |  +--ro x733:proposed-repair-actions*   string
     |  |  +--ro x733:trend-indication?          trend
     |  |  +--ro x733:backedup-status?           boolean
     |  |  +--ro x733:backup-object?             al:resource
     |  |  +--ro x733:additional-information* [identifier]
     |  |  |  +--ro x733:identifier     string
     |  |  |  +--ro x733:significant?   boolean
     |  |  |  +--ro x733:information?   string
     |  |  +--ro x733:security-alarm-detector?   al:resource
     |  |  +--ro x733:service-user?              al:resource
     |  |  +--ro x733:service-provider?          al:resource
     |  +---x purge-shelved-alarms
     |  |  +---w input
     |  |  |  +---w alarm-clearance-status    enumeration
     |  |  |  +---w older-than!
     |  |  |  |  +---w (age-spec)?
     |  |  |  |     +--:(seconds)
     |  |  |  |     |  +---w seconds?   uint16
     |  |  |  |     +--:(minutes)
     |  |  |  |     |  +---w minutes?   uint16
     |  |  |  |     +--:(hours)
     |  |  |  |     |  +---w hours?   uint16
     |  |  |  |     +--:(days)
     |  |  |  |     |  +---w days?   uint16
     |  |  |  |     +--:(weeks)
     |  |  |  |        +---w weeks?   uint16
     |  |  |  +---w severity!
     |  |  |  |  +---w (sev-spec)?
     |  |  |  |     +--:(below)
     |  |  |  |     |  +---w below?   severity
     |  |  |  |     +--:(is)
     |  |  |  |     |  +---w is?   severity
     |  |  |  |     +--:(above)
     |  |  |  |        +---w above?   severity
     |  |  |  +---w operator-state-filter! {operator-actions}?
     |  |  |     +---w state?   operator-state
     |  |  |     +---w user?    string
     |  |  +--ro output
     |  |     +--ro purged-alarms?   uint32
     |  +---x compress-shelved-alarms {alarm-history}?
     |     +---w input
     |     |  +---w resource?               -> /alarms/shelved-alarms/shelved-alarm/resource
     |     |  +---w alarm-type-id?          -> /alarms/shelved-alarms/shelved-alarm/alarm-type-id
     |     |  +---w alarm-type-qualifier?   -> /alarms/shelved-alarms/shelved-alarm/alarm-type-qualifier
     |     +--ro output
     |        +--ro compressed-alarms?   uint32
     +--rw alarm-profile* [alarm-type-id alarm-type-qualifier-match resource] {alarm-profile}?
     |  +--rw alarm-type-id                        alarm-type-id
     |  +--rw alarm-type-qualifier-match           string
     |  +--rw resource                             resource-match
     |  +--rw description                          string
     |  +--rw alarm-severity-assignment-profile {severity-assignment}?
     |     +--rw severity-level*   severity
     +--ro an-alm:historical-alarms
     |  +--ro an-alm:number-of-historical-alarm?       yang:gauge32
     |  +--ro an-alm:historical-alarms-last-changed?   yang:date-and-time
     |  +--ro an-alm:historical-alarm* [notification-serial-id]
     |     +--ro an-alm:notification-serial-id         yang:gauge32
     |     +--ro an-alm:alarm-name?                    string
     |     +--ro an-alm:resource                       al:resource
     |     +--ro an-alm:alarm-type-id                  al:alarm-type-id
     |     +--ro an-alm:alarm-type-qualifier?          al:alarm-type-qualifier
     |     +--ro an-alm:severity                       al:severity
     |     +--ro an-alm:fault-flag                     enumeration
     |     +--ro an-alm:time-created                   yang:date-and-time
     |     +--ro an-alm:recover-time?                  yang:date-and-time
     |     +--ro an-alm:alarm-text?                    string
     |     +--ro an-alm:probable-cause-desc?           string
     |     +--ro an-alm:probable-cause-code?           int32
     |     +--ro an-alm:proposed-advise?               string
     |     +--ro hw-alarm-ext:object-type?             object-type
     |     +--ro hw-alarm-ext:event-type?              x733:event-type
     |     +--ro hw-alarm-ext:threshold-information
     |     |  +--ro hw-alarm-ext:triggered-threshold?   string
     |     |  +--ro hw-alarm-ext:observed-value?        x733:value-type
     |     |  +--ro (hw-alarm-ext:threshold-level)?
     |     |  |  +--:(hw-alarm-ext:up)
     |     |  |  |  +--ro hw-alarm-ext:up-high?   x733:value-type
     |     |  |  |  +--ro hw-alarm-ext:up-low?    x733:value-type
     |     |  |  +--:(hw-alarm-ext:down)
     |     |  |     +--ro hw-alarm-ext:down-low?    x733:value-type
     |     |  |     +--ro hw-alarm-ext:down-high?   x733:value-type
     |     |  +--ro hw-alarm-ext:arm-time?              yang:date-and-time
     |     +--ro hw-alarm-ext:additional-information* [identifier]
     |        +--ro hw-alarm-ext:identifier     string
     |        +--ro hw-alarm-ext:significant?   boolean
     |        +--ro hw-alarm-ext:information?   string
     +--ro ccsa-an-alm:historical-alarms
     |  +--ro ccsa-an-alm:number-of-historical-alarm?       yang:gauge32
     |  +--ro ccsa-an-alm:historical-alarms-last-changed?   yang:date-and-time
     |  +--ro ccsa-an-alm:historical-alarm* [notification-serial-id]
     |     +--ro ccsa-an-alm:notification-serial-id    yang:gauge32
     |     +--ro ccsa-an-alm:alarm-name?               string
     |     +--ro ccsa-an-alm:resource                  al:resource
     |     +--ro ccsa-an-alm:alarm-type-id             al:alarm-type-id
     |     +--ro ccsa-an-alm:alarm-type-qualifier?     al:alarm-type-qualifier
     |     +--ro ccsa-an-alm:severity                  al:severity
     |     +--ro ccsa-an-alm:fault-flag                enumeration
     |     +--ro ccsa-an-alm:time-created              yang:date-and-time
     |     +--ro ccsa-an-alm:recover-time?             yang:date-and-time
     |     +--ro ccsa-an-alm:alarm-text?               string
     |     +--ro ccsa-an-alm:probable-cause-desc?      string
     |     +--ro ccsa-an-alm:probable-cause-code?      int32
     |     +--ro ccsa-an-alm:proposed-advise?          string
     |     +--ro hw-alm:historical-alarm
     |        +--ro hw-alm:event-type?                alx:event-type
     |        +--ro hw-alm:threshold
     |        |  +--ro hw-alm:triggered-threshold?   string
     |        |  +--ro hw-alm:observed-value?        alx:value-type
     |        |  +--ro (hw-alm:threshold-level)?
     |        |  |  +--:(hw-alm:up)
     |        |  |  |  +--ro hw-alm:up-high?   alx:value-type
     |        |  |  |  +--ro hw-alm:up-low?    alx:value-type
     |        |  |  +--:(hw-alm:down)
     |        |  |     +--ro hw-alm:down-low?    alx:value-type
     |        |  |     +--ro hw-alm:down-high?   alx:value-type
     |        |  +--ro hw-alm:arm-time?              yang:date-and-time
     |        +--ro hw-alm:additional-informations
     |           +--ro hw-alm:additional-information* [identifier]
     |              +--ro hw-alm:identifier     string
     |              +--ro hw-alm:significant?   boolean
     |              +--ro hw-alm:information?   string
     +--rw hw-alarm-ext:alarm-configurations
     |  +--rw hw-alarm-ext:alarm-configuration* [alarm-type-id alarm-type-qualifier]
     |     +--rw hw-alarm-ext:alarm-type-id           al:alarm-type-id
     |     +--rw hw-alarm-ext:alarm-type-qualifier    al:alarm-type-qualifier
     |     +--rw hw-alarm-ext:severity-level?         al:severity
     |     +--rw hw-alarm-ext:convert-flag?           convert-flag
     |     +--rw hw-alarm-ext:alarm-effect?           effect-type
     +--rw hw-alarm-ext:alarm-filters
     |  +--rw hw-alarm-ext:alarm-filter* [filter-object filter-type]
     |     +--rw hw-alarm-ext:filter-object         object-type
     |     +--rw hw-alarm-ext:filter-type           filter-type
     |     +--rw (hw-alarm-ext:filter-condition)?
     |        +--:(hw-alarm-ext:levels)
     |        |  +--rw hw-alarm-ext:alarm-level?   al:severity
     |        +--:(hw-alarm-ext:types)
     |        |  +--rw hw-alarm-ext:alarm-type*   x733:event-type
     |        +--:(hw-alarm-ext:ids)
     |        |  +--rw hw-alarm-ext:alarm-id*   uint32
     |        +--:(hw-alarm-ext:parameters)
     |           +--rw hw-alarm-ext:alarm-para*   string
     +--rw hw-alarm-ext:alarm-jitter
        +--rw hw-alarm-ext:jitter-enabled?   boolean
        +--rw hw-alarm-ext:jitter-time?      uint32

  notifications:
    +---n alarm-notification
    |  +---- resource                              resource
    |  +---- alarm-type-id                         alarm-type-id
    |  +---- alarm-type-qualifier?                 alarm-type-qualifier
    |  +---- alt-resource*                         resource
    |  +---- related-alarm* [resource alarm-type-id alarm-type-qualifier] {alarm-correlation}?
    |  |  +---- resource                -> /alarms/alarm-list/alarm/resource
    |  |  +---- alarm-type-id           -> /alarms/alarm-list/alarm[resource=current()/../resource]/alarm-type-id
    |  |  +---- alarm-type-qualifier    -> /alarms/alarm-list/alarm[resource=current()/../resource][alarm-type-id=current()/../alarm-type-id]/alarm-type-qualifier
    |  +---- impacted-resource*                    resource {service-impact-analysis}?
    |  +---- root-cause-resource*                  resource {root-cause-analysis}?
    |  +---- time                                  yang:date-and-time
    |  +---- perceived-severity                    severity-with-clear
    |  +---- alarm-text                            alarm-text
    |  +---- an-alm:notification-serial-id?        yang:gauge32
    |  +---- an-alm:alarm-name?                    string
    |  +---- ccsa-an-alm:notification-serial-id?   yang:gauge32
    |  +---- ccsa-an-alm:alarm-name?               string
    |  +---- x733:event-type?                      event-type
    |  +---- x733:probable-cause?                  uint32
    |  +---- x733:probable-cause-string?           string
    |  +---- x733:threshold-information
    |  |  +---- x733:triggered-threshold?   string
    |  |  +---- x733:observed-value?        value-type
    |  |  +---- (x733:threshold-level)?
    |  |  |  +--:(x733:up)
    |  |  |  |  +---- x733:up-high?   value-type
    |  |  |  |  +---- x733:up-low?    value-type
    |  |  |  +--:(x733:down)
    |  |  |     +---- x733:down-low?    value-type
    |  |  |     +---- x733:down-high?   value-type
    |  |  +---- x733:arm-time?              yang:date-and-time
    |  +---- x733:monitored-attributes* [id]
    |  |  +---- x733:id       al:resource
    |  |  +---- x733:value?   string
    |  +---- x733:proposed-repair-actions*         string
    |  +---- x733:trend-indication?                trend
    |  +---- x733:backedup-status?                 boolean
    |  +---- x733:backup-object?                   al:resource
    |  +---- x733:additional-information* [identifier]
    |  |  +---- x733:identifier     string
    |  |  +---- x733:significant?   boolean
    |  |  +---- x733:information?   string
    |  +---- x733:security-alarm-detector?         al:resource
    |  +---- x733:service-user?                    al:resource
    |  +---- x733:service-provider?                al:resource
    +---n alarm-inventory-changed

module: ietf-telemetry-message

  structure message:
    +-- network-node-manifest {network-node-manifest}?
    |  +-- name?               string
    |  +-- vendor?             string
    |  +-- vendor-pen?         uint32
    |  +-- software-version?   string
    |  +-- software-flavor?    string
    |  +-- os-version?         string
    |  +-- os-type?            string
    +-- telemetry-message-metadata
    |  +-- node-export-timestamp?    yang:date-and-time
    |  +-- collection-timestamp      yang:date-and-time
    |  +-- notification-event        telemetry-notification-event-type
    |  +-- sequence-number?          yang:counter32
    |  +-- session-protocol          telemetry-session-protocol-type
    |  +-- export-address            inet:host
    |  +-- export-port?              inet:port-number
    |  +-- collection-address?       inet:host
    |  +-- collection-port?          inet:port-number
    |  +-- yang-push-subscription
    |     +-- id?                        sn:subscription-id
    |     +-- (filter-spec)?
    |     |  +--:(subtree-filter)
    |     |  |  +-- subtree-filter?   anydata
    |     |  +--:(xpath-filter)
    |     |     +-- xpath-filter?   yang:xpath1.0
    |     +-- (target)?
    |     |  +--:(stream)
    |     |  |  +-- stream?   string
    |     |  +--:(datastore)
    |     |     +-- datastore?   identityref
    |     +-- transport?                 sn:transport
    |     +-- encoding?                  sn:encoding
    |     +-- purpose?                   string
    |     +-- (update-trigger)?
    |     |  +--:(periodic)
    |     |  |  +-- periodic!
    |     |  |     +-- period?        yp:centiseconds
    |     |  |     +-- anchor-time?   yang:date-and-time
    |     |  +--:(on-change)
    |     |     +-- on-change!
    |     |        +-- dampening-period?   yp:centiseconds
    |     |        +-- sync-on-start?      boolean
    |     +-- module* [name]
    |     |  +-- name        yang:yang-identifier
    |     |  +-- revision?   rev:revision-date
    |     |  +-- version?    ysver:version
    |     +-- yang-library-content-id?   string
    +-- data-collection-manifest {data-collection-manifest}?
    |  +-- name?               string
    |  +-- vendor?             string
    |  +-- vendor-pen?         uint32
    |  +-- software-version?   string
    |  +-- software-flavor?    string
    |  +-- os-version?         string
    |  +-- os-type?            string
    +-- network-operator-metadata
    |  +-- labels* [name]
    |     +-- name       string
    |     +-- (value)
    |        +--:(number-choice)
    |        |  +-- (number-choice)?
    |        |     +--:(number-value)
    |        |        +-- number-value?   uint64
    |        +--:(string-choice)
    |        |  +-- (string-choice)?
    |        |     +--:(string-value)
    |        |        +-- string-value?   string
    |        +--:(anydata-choice)
    |           +-- (anydata-choice)?
    |              +--:(anydata-values)
    |                 +-- anydata-values?   anydata
    +-- payload?                      anydata
```


## 6. YANG Message Broker Consumer - YANG Telemetry Message Schema Validation

With the previously generated YANG schema tree, YANG Telemetry Message schema validation is performed.


### 6.1 NetGauze Implementation

Below shows the YANG Message Broker message consumption for schema id `527`. It details the topic offset, YANG schema id and message key (currently the YANG-Push publisher node IP address), the message itself and wherever the message was validated successfully or not.

```
root@daisy-playground-rh8 [ /opt/NetGauze-bin ] () # RUST_LOG=kafka_yang_consumer=debug,info ./kafka-yang-consumer -c librdkafka-sbd.json -s https://schema-registry-sc.olt.stage.sbd.corproot.net --group daisy.dev. -t daisy.dev.device-yang-raw -n 1000 | grep "10.190.64.79" | grep -e 'schema_id: 527'
2026-02-03T10:02:28.021308Z DEBUG kafka_yang_consumer: Message Payload [partition: 0, offset: 96087394, key: "10.190.64.79", schema_id: 527]: {"ietf-telemetry-message:message":{"data-collection-manifest":{"name":"devcolleft01NetGauzeudpnotifyangpushleft","os-type":"Red Hat Enterprise Linux","os-version":"8.10","software-flavor":"release","software-version":"0.9.0 (9eb309f6)","vendor":"NetGauze","vendor-pen":3746},"network-operator-metadata":{"labels":[{"name":"platform_id","string-value":"FANO"},{"name":"node_id","string-value":"ipd-zbl1536-s-ah-79"}]},"payload":{"ietf-yp-notification:envelope":{"contents":{"ietf-yang-push:push-change-update":{"datastore-changes":{"yang-patch":{"edit":[{"edit-id":"0","operation":"merge","target":"/ietf-alarms:alarm-notification","value":{"ietf-alarms:alarm-notification":{"alarm-text":"The managing user of the equipment logout or logon","alarm-type-qualifier":"daisy1.SSH.10.212.242.71.Log on","an-alarm-management:alarm-name":"The managing user of the equipment logout or logon","an-alarm-management:notification-serial-id":78673,"huawei-alarm-type-an:alarm-type-id":"hw-alarm-type-an:managing-user-login-logout","ietf-alarms-x733:additional-information":[{"identifier":"Alarm-id","information":"239312897","significant":true},{"identifier":"Alarm-class","information":"security","significant":true},{"identifier":"Alarm-sn","information":"75917","significant":true},{"identifier":"Alarm-format","information":"system","significant":true},{"identifier":"User name","information":"daisy1","significant":true},{"identifier":"Log mode","information":"SSH","significant":true},{"identifier":"IP","information":"10.212.242.71","significant":true},{"identifier":"State","information":"Log on","significant":true}],"ietf-alarms-x733:event-type":"environmental-alarm","ietf-alarms-x733:probable-cause":234881026,"ietf-alarms-x733:probable-cause-string":"The maintenance user logs in to the system, logs out of the system, or fails to log in to the system","ietf-alarms-x733:proposed-repair-actions":"No need to deal with it","perceived-severity":"minor","resource":"system","time":"2026-02-03T10:02:11Z"}}}],"patch-id":"318"}},"id":27,"ietf-distributed-notif:message-publisher-id":3021116856,"ietf-yp-observation:point-in-time":"state-changed","ietf-yp-observation:timestamp":"2026-02-03T10:02:11.110Z"}},"event-time":"2026-02-03T10:02:11.440Z","hostname":"ipd-zbl1536-s-ah-79","sequence-number":319}},"telemetry-message-metadata":{"collection-timestamp":"2026-02-03T10:02:11.447919067Z","export-address":"10.190.64.79","export-port":10100,"node-export-timestamp":"2026-02-03T10:02:11.440Z","notification-event":"log","session-protocol":"yang-push"}}}
2026-02-03T10:02:28.662404Z DEBUG kafka_yang_consumer: Message validation PASSED - partition: 0, offset: 96087394, key: "10.190.64.79", schema_id: 527
```

### 6.1 NetGauze Impediments

Schema validation only supports validation of first YANG structure, in this case the telemetry-message message structure and doesn't perform andydata validation if it is in such a nested YANG structure. These constrains are with libyang 4.2.2 and has been addressed in libyang 4.9.1 but not yet integrated into NetGauze.