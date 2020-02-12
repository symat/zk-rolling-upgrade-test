# ZooKeeper Rolling Upgrade / Restart test

This repo contains scripts that allows you to start a ZooKeeper cluster, then one-by-one restart the servers with new configuration and/or using totally new binaries.

**note:** this repo contains scripts from https://github.com/phunt/zk-smoketest, kudos goes for Patrick Hunt for these!

**preparation:**
```
# these needed for the smoketest
apt-get install python-dev
export PYTHONPATH=`pwd`/lib-zk_3.5.5-py_2.7.5-x86_64 
export LD_LIBRARY_PATH=$PYTHONPATH

# all the data / logs / configs will be generated into the workdir
export WORKDIR=/tmp/zk-rolling-upgrade

# you need to configure the old ZooKeeper binaries and the new one (these can be the same too)
export OLD_ZK=`pwd`/apache-zookeeper-3.5.6-bin
export NEW_ZK=~/git/zookeeper

# in this example we use a custom ZooKeeper. You need to use 'mvn install' to have the new artifacts generated.
cd $NEW_ZK
mvn clean install -DskipTests
cd -
``` 

**steps for verifying rolling restart:**
- cleanup: `rm -Rf $WORKDIR/ && mkdir -p $WORKDIR`
- start a 3 node cluster with the old ZooKeeper version (using zoo.cfg.template): `./start_old_cluster.sh`
- run basic smoketest on all servers: `./zk-smoketest.py --servers=127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183`
- stop a single server: `./stop_single_server.sh 1`
- start the same server using the new ZooKeeper version: 
  - start it with the same config (based on zoo.cfg.template): `./start_single_new_server.sh 1`
  - start it based on a new config template: `./start_single_new_server.sh 1 custom_zoo.cfg.template`
- run basic smoketest on all servers: `./zk-smoketest.py --servers=127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183`
- do the same for server 2 and 3
- in the end stop the whole cluster using: `./stop_cluster.sh`

**debugging:**

You can find under `WORKDIR` a subfolder for each server instance with:
- configs
- data folder
- myid file
- logs

**fine tuning:**
- change the log settings in the log4j.properties file
- change the config in: zoo.cfg.template
