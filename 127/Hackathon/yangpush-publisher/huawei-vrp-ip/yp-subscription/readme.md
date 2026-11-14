### Netconf Interactive Login
```
netconf-console2 --host=10.215.136.48 --port=830 --db=running -i --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-ietf-env
```

### Netconf Get YANG-Push subscriptions
```
netconf-console2 --host=10.215.136.48 --port=830 --db=running --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-ietf-env --rpc=get-yp-subscription.xml
```

### Netconf Create YANG-Push subscriptions with receiver
```
netconf-console2 --host=10.215.136.48 --port=830 --db=running --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-ietf-env --edit-config=edit-config-yp-subscription-receiver-add.xml
```

### Netconf Delete YANG-Push subscriptions with receiver
```
netconf-console2 --host=10.215.136.48 --port=830 --db=running --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-ietf-env --edit-config=edit-config-yp-subscription-receiver-delete.xml
```