#!/bin/sh

# Create a directory for certificates
# mkdir -p certs

# Generate a root CA key
openssl genrsa -out certs/root-ca-key.pem 2048

# Generate a root CA certificate
openssl req -x509 -new -nodes -key certs/root-ca-key.pem -days 3650 -out certs/root-ca.pem -subj "/C=TH/ST=None/L=Bangkok/O=42/CN=ELK-CA"

# Generate a key for Elasticsearch
openssl genrsa -aes256 -passout pass:$ELASTIC_PASSWORD -out certs/elasticsearch-key.pem 2048

# Generate a Certificate Signing Request (CSR) for Elasticsearch
openssl req -new -key certs/elasticsearch-key.pem  -passin pass:$ELASTIC_PASSWORD -out certs/elasticsearch.csr -subj "/C=TH/ST=None/L=Bangkok/O=42/CN=elasticsearch"

# Generate the certificate for Elasticsearch
openssl x509 -req -in certs/elasticsearch.csr -CA certs/root-ca.pem -CAkey certs/root-ca-key.pem -CAcreateserial -out certs/elasticsearch.pem -days 365

# Generate a key for Kibana
openssl genrsa -aes256 -passout pass:$KIBANA_PASSWORD -out certs/kibana-key.pem 2048

# Generate a Certificate Signing Request (CSR) for Kibana
openssl req -new -key certs/kibana-key.pem -passin pass:$KIBANA_PASSWORD -out certs/kibana.csr -subj "/C=TH/ST=None/L=Bangkok/O=42/CN=kibana"

# Generate the certificate for Kibana
openssl x509 -req -in certs/kibana.csr -CA certs/root-ca.pem -CAkey certs/root-ca-key.pem -CAcreateserial -out certs/kibana.pem -days 365

# Set appropriate permissions
chmod 644 certs/*