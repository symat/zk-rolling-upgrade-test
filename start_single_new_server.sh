#!/usr/bin/env bash
WORKDIR=${WORKDIR:-/tmp/zk-rolling-restart}
id=${1:-1}
config_template=${2:-./zoo.cfg.template}

echo "starting server $id"
SERVER_DIR=$WORKDIR/server-$id

sed "s#WORKDIR#${SERVER_DIR}#g;s#CLIENTPORT#218${id}#g;" ${config_template} > ${SERVER_DIR}/zoo.cfg


cd $NEW_ZK
ZOO_LOG_DIR=${SERVER_DIR} ./bin/zkServer.sh --config ${SERVER_DIR} start
cd -
