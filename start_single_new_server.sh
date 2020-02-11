#!/usr/bin/env bash
WORKDIR=${WORKDIR:-/tmp/zk-rolling-restart}
id=${1:-1}

echo "starting server $id"
SERVER_DIR=$WORKDIR/server-$id


cd $NEW_ZK
ZOO_LOG_DIR=${SERVER_DIR} ./bin/zkServer.sh --config ${SERVER_DIR} start
cd -
