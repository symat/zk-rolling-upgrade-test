#!/usr/bin/env bash
WORKDIR=${WORKDIR:-/tmp/zk-rolling-restart}

for id in {1..3}
do
  echo "stopping server $id"
  SERVER_DIR=$WORKDIR/server-$id

  cd $OLD_ZK
  ZOO_LOG_DIR=${SERVER_DIR} ./bin/zkServer.sh --config ${SERVER_DIR} stop
  cd -
done