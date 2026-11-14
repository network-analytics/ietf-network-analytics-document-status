### Netconf Interactive Login
```
netconf-console2 --host=10.190.64.79 --port=830 --db=running -i --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-dev-env
```

### Netconf Get YANG-Push subscriptions
```
netconf-console2 --host=10.190.64.79 --port=830 --db=running --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-dev-env --rpc=get-yp-subscription.xml
```

### Netconf Create YANG-Push subscriptions with receiver
```
netconf-console2 --host=10.190.64.79 --port=830 --db=running --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-dev-env --edit-config=edit-config-yp-subscription-receiver-add.xml
```

### Netconf Delete YANG-Push subscriptions with receiver
```
netconf-console2 --host=10.190.64.79 --port=830 --db=running --user=daisy1 --privKeyFile=/etc/daisy/netgauze/netconf/id_rsa-dev-env --edit-config=edit-config-yp-subscription-receiver-delete.xml
```