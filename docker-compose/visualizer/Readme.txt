# Run the Visualizer sample on the Swarm
docker stack deploy -c docker-compose-visualizer.yml visualizer

# Label Docker Swarm nodes
# Add labels to specific nodes (change the names to match your environment)
# REF: https://medium.com/@kalahari/running-a-mongodb-replica-set-on-docker-1-12-swarm-mode-step-by-step-a5f3ba07d06e
docker node update --label-add swarm.node=1 $(docker node ls -q -f name=tx-chatops-dev-swarm1-node1)
docker node update --label-add swarm.node=2 $(docker node ls -q -f name=tx-chatops-dev-swarm1-node2)
docker node update --label-add swarm.node=3 $(docker node ls -q -f name=tx-chatops-dev-swarm1-node3)
# Remove labels
#docker node update --label-rm swarm.node $(docker node ls -q -f name=tx-chatops-dev-swarm1-node1)
#docker node update --label-rm swarm.node $(docker node ls -q -f name=tx-chatops-dev-swarm1-node2)
#docker node update --label-rm swarm.node $(docker node ls -q -f name=tx-chatops-dev-swarm1-node3)