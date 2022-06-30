#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

# cd prometheus
whoami
pwd
ls -l /vagrant
cd /vagrant/prometheus
pwd

#multiple IP issues
HOST_SECOND_IP=$(hostname -I | awk '{print $2}') # get second IP IP address of server
echo $HOST_SECOND_IP


# docker swarm init --advertise-addr 192.168.50.6
docker swarm init --advertise-addr $HOST_SECOND_IP
docker service create --name registry --publish 5000:5000 registry:2

docker build -t localhost:5000/prometheus .
docker image ls

docker push localhost:5000/prometheus
docker stack deploy -c compose.yml prometheus

# https://prometheus.io/docs/prometheus/latest/getting_started/
# curl http://$HOST_SECOND_IP:9090 #Prometheus
#verify that Prometheus is serving metrics about itself by navigating to its metrics endpoint
# curl http://$HOST_SECOND_IP:9090/metrics 
# Prometheus's built-in expression browser
# curl http://$HOST_SECOND_IP:9090/graph

# curl http://$HOST_SECOND_IP:3000 #Grafana default u/p admin/admin