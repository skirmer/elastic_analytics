#!/bin/bash

set -e

echo "collecting arguments..."

DEFAULT_VERSION="6.2"
MAJOR_VERSION=${1:-DEFAULT_VERSION}
echo "major version: $MAJOR_VERSION"

WDIR=$(pwd)/supporting_materials
TESTDIR=${WDIR}/sandbox
MAPPING_FILE2=${WDIR}/data_mapping.json
ES_HOST="127.0.0.1"

echo "Starting up Elasticsearch..."

case "${MAJOR_VERSION}" in

1.0) docker run -d -p 9200:9200 barnybug/elasticsearch:1.0.0
    ;;
1.4) docker run -d -p 9200:9200 barnybug/elasticsearch:1.4.4
    ;;
1.7) docker run -d -p 9200:9200 barnybug/elasticsearch:1.7.2
    ;;
2.0) docker run -d -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:2.0.2
    ;;
2.1) docker run -d -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:2.1.2
    ;;
2.2) docker run -d -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:2.2.2
    ;;
2.3) docker run -d -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:2.3.5
    ;;
2.4) docker run -d -p 9200:9200 docker.elastic.co/elasticsearch/elasticsearch:2.4.6
    ;;
5.0) docker run -d -p 9200:9200 \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:5.0.2
    ;;
5.3) docker run -d -p 9200:9200 \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:5.3.3
    ;;
5.4) docker run -d -p 9200:9200 \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:5.4.3
    ;;
5.5) docker run -d -p 9200:9200 \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:5.5.3
    ;;
5.6) docker run -d -p 9200:9200 \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:5.6.9
    ;;
6.0) docker run -d -p 9200:9200 \
          -e "discovery.type=single-node" \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:6.0.1
    ;;
6.1) docker run -d -p 9200:9200 \
          -e "discovery.type=single-node" \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:6.1.4
    ;;
6.2) docker run -d -p 9200:9200 \
          -e "discovery.type=single-node" \
          -e "xpack.security.enabled=false" \
          docker.elastic.co/elasticsearch/elasticsearch:6.2.4
    ;;
*) echo "Did not recognize version ${MAJOR_VERSION}. Not starting Elasticsearch"
   exit 1
   ;;
esac

echo "Elasticsearch v${MAJOR_VERSION} is now running on localhost:9200"

echo "Setting up local testing environment"

# Creating testing directory
mkdir -p ${TESTDIR}

# Get data
cp ${MAPPING_FILE2} ${TESTDIR}/data_mapping.json
cd ${TESTDIR}

# give the cluster a chance
sleep 25
     
# Create utexas index and utexas mapping
curl -X PUT "http://${ES_HOST}:9200/utexas" \
     -H 'Content-Type: application/json' \
     -d @data_mapping.json

# Refresh all indices
curl -X POST "http://${ES_HOST}:9200/_refresh"

# Check that we got the mappings right
curl -X GET "http://${ES_HOST}:9200/utexas/_mapping"

cd ${WDIR}

echo ""
echo "Your local environment is ready!"
