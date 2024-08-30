# check response from Elasticsearch service
curl -u elastic:admos1234 http://localhost:9200

# check Kibana get response from Elasticsearch
docker exec -it kibana curl -X GET -u elastic:admos1234 http://elasticsearch:9200