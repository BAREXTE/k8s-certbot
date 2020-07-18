#!/bin/bash

# init vars
domains_arr=($CERT_DOMAINS)
req_cn=${domains_arr[0]}
req_san="DNS:$req_cn"
req_cc=$CERT_COUNTRY
req_province=$CERT_PROVINCE
req_city=$CERT_CITY
req_org=$CERT_ORG
req_email=$CERT_EMAIL
req_ou=$CERT_OU

private_key="/etc/k8s-certbot/secret/tls.key"

# parse domains_arr to req_san
for domain in ${domains_arr[@]/$req_cn}
do
    req_san="$req_san,DNS:$domain"
done

# init easy-rsa
cd /usr/share/easy-rsa/
./easyrsa --batch clean-all

# import private key if exist
if test -f "$private_key"; then
    cp $private_key "/usr/share/easy-rsa/pki/private/$req_cn.key"
fi

# generate csr
./easyrsa --batch --keysize=4096 --dn-mode=org --subject-alt-name="${req_san}" --req-c="${req_cc}" --req-st="${req_province}" --req-city="${req_city}" --req-org="${req_org}" --req-email="${req_email}" --req-ou="${req_ou}" --req-cn="${req_cn}" gen-req "${req_cn}" nopass
