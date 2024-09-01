# load environment into current shell
source elk/.env

# check response from Elasticsearch service
curl -u elastic:es1234 http://localhost:9200

# check Kibana get response from Elasticsearch
docker exec -it kibana curl -X GET -u elastic:${ELASTIC_PASSWORD} http://elasticsearch:9200

# access postgres
psql -h localhost -p 3210 -U postgres

# chekc Elastic with SSL
curl -X GET "https://localhost:9200" -k -u elastic:${ELASTIC_PASSWORD}

curl -X GET "https://localhost:9200/_cat/indices?v" -k -u elastic:${ELASTIC_PASSWORD}

curl -X GET "https://localhost:9200/_cat/indices/logs-*?v" -k -u elastic:${ELASTIC_PASSWORD}

curl -X GET "https://localhost:9200/django-logs-2024.09.01/_search" -k -u elastic:${ELASTIC_PASSWORD}