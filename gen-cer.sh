#!/bin/bash

domains_arr=($CERT_DOMAINS)
req_cn=${domains_arr[0]}
req_email=$CERT_EMAIL

certbot certonly --agree-tos -m $req_email --webroot --webroot-path /usr/share/nginx/html --csr /usr/share/easy-rsa/pki/reqs/$req_cn.req
