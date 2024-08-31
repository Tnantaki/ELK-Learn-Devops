#!/bin/bash

# Wait for Elasticsearch to be available
until [ "$(curl -s --cacert config/certs/root-ca.pem -w "%{http_code}" -u elastic:$ELASTIC_PASSWORD -k https://elasticsearch:9200 -o /dev/null)" -eq 200 ]
do
  echo "Waiting for connect to elasticsearch..."
  sleep 10
done

echo "Setting kibana_system password";
curl -u elastic:$ELASTIC_PASSWORD -X POST \
  -s --cacert config/certs/root-ca.pem \
  https://elasticsearch:9200/_security/user/kibana_system/_password \
  -d '{"password":"'"$KIBANA_PASSWORD"'"}' \
  -H 'Content-Type: application/json'

# Start Kibana
exec /usr/share/kibana/bin/kibana