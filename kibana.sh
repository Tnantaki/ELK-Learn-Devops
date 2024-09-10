# # Wait for Kibana to be fully up and running
# echo "Waiting for Kibana to be ready..."
# KIBANA_URL="https://localhost:5601"
# until curl -s -o /dev/null -w "%{http_code}" $KIBANA_URL | grep -q "200"; do
#   echo "Kibana is not ready yet. Waiting..."
#   sleep 10
# done

# Import visualizations to Kibana
echo "Set Kibana visualizations from visualization.ndjson..."

KIBANA_URL="https://localhost:5601"
ELASTIC_PASSWORD=es1234
KIBANA_PORT=5601

# response=$(curl -s -o https://localhost:5601/api/status)
# -w for get http_code
response=$(curl -s -k -w "%{http_code}" -u elastic:$ELASTIC_PASSWORD \
  -X GET https://localhost:5601/api/status -o /dev/null)

# response=$(curl -s -k -o /dev/null -w "%{http_code}" -X POST \
#   "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
#   -H "kbn-xsrf: true" \
#   -H "Content-Type: multipart/form-data" \
#   -u "elastic:$ELASTIC_PASSWORD" \
#   -F file=@visualization.ndjson)

# response=$(curl -s -k -u elastic:$ELASTIC_PASSWORD -X POST \
#   https://elasticsearch:9200/_security/user/kibana_system/_password \
#   -d '{"password":"'"$KIBANA_SYSTEM_PASSWORD"'"}' \
#   -H 'Content-Type: application/json')

# # Check if the import was successful
if [ "$response" -eq 200 ]; then
  echo "Visualizations imported successfully."
else
    echo "Failed to import visualizations. HTTP response code: $response"
    # exit 1
fi