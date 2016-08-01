# To manually build with docker
docker build --rm -t local/elasticsearch-master .

docker build --rm -t ernestgwilsonii/elasticsearch-master .

# To then launch that build
docker run --name elasticsearch-master-node1 -it -d -p 9200:9200 -p 9300:9300 -p 54328:54328/udp local/elasticsearch-master

docker ps

docker login

docker push ernestgwilsonii/elasticsearch-master


# Future
docker service create --replicas 1 --name elasticsearch-master-node1 -p:9200:9200 -p:9300:9300 --update-delay 10s --update-parallelism 1 ernestgwilsonii/elasticsearch-master
docker service create --replicas 1 --name elasticsearch-master-node2 --update-delay 10s --update-parallelism 1 ernestgwilsonii/elasticsearch-master
docker service create --replicas 1 --name elasticsearch-master-node3 --update-delay 10s --update-parallelism 1 ernestgwilsonii/elasticsearch-master

docker service ls
docker service ps elasticsearch-master-node1


# Test
curl 'IPAddressHere:9200/_cat/health?v'
curl 'IPAddressHere:9200/_cat/nodes?v'
curl 'IPAddressHere:9200/_cat/indices?v'
curl -XGET 'http://IPAddressHere:9200/_cluster/health?pretty=true'
curl -XGET 'http://IPAddressHere:9200/_cluster/state?pretty'
curl -XGET http://IPAddressHere:9200/_cluster/settings?pretty
