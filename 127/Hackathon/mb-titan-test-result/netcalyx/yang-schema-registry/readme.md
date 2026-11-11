## YANG Schema Registry - YANG Schema Collection

### Grep - Obtain YANG Schema ID's from Message Broker Producer Logs
```bash
cd /var/log/netcalyx
grep 10.215.217.123 netcalyx-udpnotif-yangpush-testing-left.log | grep schemaID | sed -E 's/.*(subscription_id=[0-9]+).* (schema_id=[0-9]+) (content_id="[^"]+").*/\1 \2 \3/' | awk '!seen[$0]++'

subscription_id=1 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=2 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=3 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=4 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=5 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=6 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=11 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=12 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=13 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=14 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=15 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=16 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=17 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=18 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=19 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=20 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=21 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=22 schema_id=119660 content_id="c54630fc30d564b5de51c670ac1e0d898111b11953902eb2bf34ba8158480b01"
subscription_id=23 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=25 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=27 schema_id=119618 content_id="4cf30b8326e43282d86d8226fc8611afedef6359bef8e04f2d19dea30c848c08"
subscription_id=81 schema_id=119626 content_id="ca94d36bc02e172d804c91de8cafeef46d45c6fe55657c9c700b6ce61115fcb3"
subscription_id=82 schema_id=119633 content_id="369536a436f0d21eabc81ef220e3fca8ac933c667eb26937ef05fb4d499c6fed"
subscription_id=83 schema_id=119638 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"
subscription_id=84 schema_id=119638 content_id="0367a6dbc536a7ff62430c9e163638c8083abd7745ff8e92ffcd42eb13aa4114"
subscription_id=85 schema_id=119636 content_id="8a199e95f7dc22c9d48e427d76647fd6dd56e046501b2370d76c03d573eda4c3"
subscription_id=86 schema_id=119630 content_id="9b24ab29c609d764dff3c5d9b7326056a7bcb9e680be565b9f2d15fca86e1b00"
subscription_id=87 schema_id=119641 content_id="da952479f7ed21edea0aa95fec17fdc2eb1622954201c5216bbd12655a44c287"
subscription_id=88 schema_id=119653 content_id="1c5665b1bda78f76baaec1afe3db9eb491af2d770ecc678d9b2fbf3bb4dec5cf"
subscription_id=89 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=90 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=91 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=92 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=93 schema_id=119623 content_id="801df0c5753fb081e3ebbf892a68e94900c156bdf96f7648a92d947471cb33cd"
subscription_id=94 schema_id=119657 content_id="7d667a00976c1fe2f927b065214b45bc398f2192bd05572e424a60d12e3ed0f9"
```

### Curl - Obtain YANG Schemas from Schema Registry
```bash
curl http://10.212.242.4:8080/schemas/ids/119618  > schema_id_119618.json
curl http://10.212.242.4:8080/schemas/ids/119660  > schema_id_119660.json
curl http://10.212.242.4:8080/schemas/ids/119626  > schema_id_119626.json
curl http://10.212.242.4:8080/schemas/ids/119633  > schema_id_119633.json
curl http://10.212.242.4:8080/schemas/ids/119638  > schema_id_119638.json
curl http://10.212.242.4:8080/schemas/ids/119636  > schema_id_119636.json
curl http://10.212.242.4:8080/schemas/ids/119630  > schema_id_119630.json
curl http://10.212.242.4:8080/schemas/ids/119653  > schema_id_119653.json
curl http://10.212.242.4:8080/schemas/ids/119623  > schema_id_119623.json
curl http://10.212.242.4:8080/schemas/ids/119657  > schema_id_119657.json

tar -czvf titan-confluent-schemaregistry-schema-content.tar.gz schema_id_119618.json schema_id_119660.json schema_id_119626.json schema_id_119633.json schema_id_119638.json schema_id_119636.json schema_id_119630.json schema_id_119653.json schema_id_119623.json schema_id_119657.json
```