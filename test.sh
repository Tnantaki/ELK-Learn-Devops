# ------------------------------ Elasticsearch ------------------------------ #
# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200" 

# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200/_cat/indices?v"

# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200/_cat/indices/logs-*?v"

# curl -k -u elastic:${ELASTIC_PASSWORD} -X GET "https://localhost:9200/django-logs-2024.09.01/_search"

# # check Kibana get response from Elasticsearch
# docker exec -it kibana curl -X GET -u elastic:${ELASTIC_PASSWORD} http://elasticsearch:9200

# # access postgres
# psql -h localhost -p 3210 -U postgres

# ------------------------------ Test Kibana and Elastic server running ------------------------------ #
# Entrypoint
# logstash: /usr/local/bin/docker-entrypoint
# kibana: /usr/local/bin/docker-entrypoint.sh
# elasticsearch: /usr/local/bin/docker-entrypoint.sh

# load environment into current shell
# source elk/.env

# check response from Elasticsearch service
# response=$(curl -s -k -w "%{http_code}" -o /dev/null -u elastic:es1234 https://localhost:9200)

# if [ "$response" -eq 200 ]; then
#   echo "Elasticsearch server running successfully"
# else
#   echo "Failed to connect Elasticsearch: HTTP response code: $response"
# fi

# # # check response from Kibana service
# response=$(curl -s -k -w "%{http_code}" -o /dev/null -u elastic:es1234 https://localhost:5601/api/status)

# if [ "$response" -eq 200 ]; then
#   echo "Kibana server running successfully"
# else
#   echo "Failed to connect Kibana: HTTP response code: $response"
# fi

# ------------------------------ Apply Retention on Elasticsearch ------------------------------ #
# Create an ILM Policy for retention data
# - delete data after 30 days
# response=$(curl -s -k -o /dev/null -w "%{http_code}" -u elastic:es1234 \
#   -X PUT "https://localhost:9200/_ilm/policy/logstash-ilm-policy" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "policy": {
#       "phases": {
#         "hot": {
#           "actions": {}
#         },
#         "delete": {
#           "min_age": "30d",
#           "actions": {
#             "delete": {}
#           }
#         }
#       }
#     }
#   }')

# if [ "$response" -eq 200 ]; then
#   echo "Create an ILM Policy successfully"
# else
#   echo "Failed to create an ILM: HTTP response code: $response"
# fi

# Apply the ILM Policy to an Index Template
# response=$(curl -s -k -o /dev/null -w "%{http_code}" -u elastic:es1234 \
#   -X PUT "https://localhost:9200/_index_template/backend-logs-template" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "index_patterns": ["backend-logs-*"],
#     "template": {
#       "settings": {
#         "index.lifecycle.name": "logstash-ilm-policy"
#       }
#     }
#   }')

# if [ "$response" -eq 200 ]; then
#   echo "Apply Policy to index successfully"
# else
#   echo "Failed to apply the ILM: HTTP response code: $response"
# fi
