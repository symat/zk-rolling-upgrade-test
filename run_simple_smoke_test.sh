#!/usr/bin/env bash
set -e
WORKDIR=${WORKDIR:-/tmp/zk-rolling-restart}

rm -Rf $WORKDIR/ && mkdir -p $WORKDIR
./start_old_cluster.sh
sleep 2
./zk-smoketest.py --servers=127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183
echo "------------------------"
echo "  old cluster started"
echo "------------------------"

./stop_single_server.sh 1
sleep 2
./start_single_new_server.sh 1
sleep 5
./zk-smoketest.py --servers=127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183
echo "---------------------------------------"
echo "  server 1 upgraded, check logs above"
echo "---------------------------------------"

./stop_single_server.sh 2
sleep 2
./start_single_new_server.sh 2
sleep 5
./zk-smoketest.py --servers=127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183
echo "---------------------------------------"
echo "  server 2 upgraded, check logs above"
echo "---------------------------------------"


./stop_single_server.sh 3
sleep 2
./start_single_new_server.sh 3
sleep 5
./zk-smoketest.py --servers=127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183
echo "---------------------------------------"
echo "  server 3 upgraded, check logs above"
echo "---------------------------------------"

./stop_cluster.sh
