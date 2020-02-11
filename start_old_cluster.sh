#!/usr/bin/env bash
WORKDIR=${WORKDIR:-/tmp/zk-rolling-restart}

for id in {1..3}
do
  echo "starting server $id"
  SERVER_DIR=$WORKDIR/server-$id
  rm -Rf ${SERVER_DIR}
  mkdir -p ${SERVER_DIR}/zkdata
  echo "$id" > ${SERVER_DIR}/zkdata/myid
  sed "s#WORKDIR#${SERVER_DIR}#g;s#CLIENTPORT#218${id}#g;" ./zoo.cfg.template > ${SERVER_DIR}/zoo.cfg
  cp ./log4j.properties ${SERVER_DIR}

  cd $OLD_ZK
  ZOO_LOG_DIR=${SERVER_DIR} ./bin/zkServer.sh --config ${SERVER_DIR} start
  cd -
done