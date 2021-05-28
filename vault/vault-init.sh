#!/bin/sh

vault login root
vault kv put secret/production/sgyt-kirby-payment-api username='my_user' password='my_pwd'
vault auth enable kubernetes

echo $KUBE_CA_CERT_B64 > .cert.pem
base64 -d .cert.pem > cert.pem
rm .cert.pem

vault write auth/kubernetes/config \
        token_reviewer_jwt="$TOKEN_REVIEW_JWT" \
        kubernetes_host="$KUBE_HOST" \
        kubernetes_ca_cert=@cert.pem

