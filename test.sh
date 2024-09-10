# Elasticsearch
# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200" 

# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200/_cat/indices?v"

# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200/_cat/indices/logs-*?v"

# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200/django-logs-2024.09.01/_search"

# # check Kibana get response from Elasticsearch
# docker exec -it kibana curl -X GET -u elastic:${ELASTIC_PASSWORD} http://elasticsearch:9200

# # access postgres
# psql -h localhost -p 3210 -U postgres

# ------------------------------------------------------------------------------
# Entrypoint
# logstash: /usr/local/bin/docker-entrypoint
# kibana: /usr/local/bin/docker-entrypoint.sh
# elasticsearch: /usr/local/bin/docker-entrypoint.sh

# load environment into current shell
source elk/.env

# check response from Elasticsearch service
response=$(curl -s -k -w "%{http_code}" -o /dev/null -u elastic:es1234 https://localhost:9200)

if [ "$response" -eq 200 ]; then
  echo "Elasticsearch server running successfully"
else
  echo "Failed to connect Elasticsearch: HTTP response code: $response"
fi

# # check response from Kibana service
response=$(curl -s -k -w "%{http_code}" -o /dev/null -u elastic:es1234 https://localhost:5601/api/status)

if [ "$response" -eq 200 ]; then
  echo "Kibana server running successfully"
else
  echo "Failed to connect Kibana: HTTP response code: $response"
fi
