
#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

# cd prometheus
whoami
pwd

cd /tmp

#https://prometheus.io/docs/guides/node-exporter/
#https://prometheus.io/download/#node_exporter
NODE_EXPORTER_VERSION="1.3.1"
#wget https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-amd64.tar.gz
#wget -q https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
wget -q https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
rm *.tar.gz
cd node_exporter-*.*-amd64
./node_exporter &>/dev/null &
#&>/dev/null sets the command’s stdout and stderr to /dev/null instead of inheriting them from the parent process.
#& makes the shell run the command in the background
#disown removes the “current” job, last one stopped or put in the background, from under the shell’s job control
#cmd_node_exporter="./node_exporter"
#"${cmd_node_exporter}" &>/dev/null & disown

cd /tmp
#https://prometheus.io/docs/prometheus/latest/getting_started/
#https://prometheus.io/download/#prometheus
PROMETHEUS_VERSION="2.36.2"
#wget -q https://github.com/prometheus/prometheus/releases/download/v2.36.2/prometheus-2.36.2.linux-amd64.tar.gz
wget -q https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
rm *.tar.gz
cd prometheus-*

# Start Prometheus.
# By default, Prometheus stores its database in ./data (flag --storage.tsdb.path).
# ./prometheus --config.file=prometheus.yml &>/dev/null &
./prometheus --config.file=/vgarant/provisioning/prometheus.yml &>/dev/null &

#&>/dev/null sets the command’s stdout and stderr to /dev/null instead of inheriting them from the parent process.
#& makes the shell run the command in the background
#disown removes the “current” job, last one stopped or put in the background, from under the shell’s job control
#cmd_prometheus="./prometheus --config.file=prometheus.yml"
#"${cmd_prometheus}" &>/dev/null & disown


#the Node Exporter is now running and exposing metrics on port 9100
#verify that metrics are being exported by cURLing the /metrics endpoint
# curl http://localhost:9100/metrics