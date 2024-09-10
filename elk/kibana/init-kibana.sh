#!/bin/bash

# Wait for Elasticsearch to be available
# -s: silent --cacert: certs, -w %{http_code}: return http code,-u: User, -k bypass SSL (for dev only), -o: output
until [ "$(curl -s --cacert config/certs/root-ca.pem -w "%{http_code}" -u elastic:$ELASTIC_PASSWORD -k https://elasticsearch:9200 -o /dev/null)" -eq 200 ]
do
  echo "Waiting for connect to elasticsearch..."
  sleep 10
done

echo "Setting kibana_system password";

response=$(curl -s -k -o /dev/null -w "%{http_code}" -u elastic:$ELASTIC_PASSWORD \
  -X POST https://elasticsearch:9200/_security/user/kibana_system/_password \
  -d '{"password":"'"$KIBANA_SYSTEM_PASSWORD"'"}' \
  -H 'Content-Type: application/json')

if [ "$response" -eq 200 ]; then
  echo "set kibana_system succesfully"
else
  echo "Failed set kibana_system: HTTP response code: $response"
fi

# Set up signal handling
trap 'kill -TERM $PID' TERM INT

echo "Starting Kibana..."
# Start Kibana in the background
/usr/share/kibana/bin/kibana &

# Capture the PID of the Kibana process
PID=$!

# response=$(curl -s -k -o /dev/null -w "%{http_code}" -X POST \
#   "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
#   -H "kbn-xsrf: true" \
#   -H "Content-Type: multipart/form-data" \
#   -u "elastic:$ELASTIC_PASSWORD" \
#   -F file=@visualization.ndjson)

# if [ "$response" -eq 200 ]; then
#     echo "Visualizations imported successfully."
# else
#     echo "Failed to import visualizations. HTTP response code: $response"
# fi


# Wait for the Kibana process to finish
wait $PID

# Exit with the same status as the Kibana process
exit $?

# Start Kibana
# exec /usr/share/kibana/bin/kibana