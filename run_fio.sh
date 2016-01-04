#!/bin/bash

CWD=$(pwd)

# Gather system snapshot
[ ! -e linux_summary ] && git clone https://github.com/jschaub30/linux_summary
cd linux_summary
git pull
./linux_summary.sh
SNAPSHOT=$CWD/linux_summary/$(hostname -s).html
mv index.html $SNAPSHOT
cd $CWD

CONFIG_FILE=config.job
SIZE=4G

RUNDIR=$(date +"%Y%m%d-%H%M%S")
mkdir -p $RUNDIR
cp analyze.R $RUNDIR/.
cp tidy.sh $RUNDIR/.
cp $SNAPSHOT $RUNDIR/.
cp $CONFIG_FILE $RUNDIR/. 

for QD in 1 4 # 16 64  
do
  echo ======= QD=$QD =======
  #./run_once.sh OLTP1 4k $SIZE randrw 60 40 $QD $CONFIG_FILE
  #./run_once.sh OLTP2 8k $SIZE randrw 90 10 $QD $CONFIG_FILE
  #random read write mix with cache hits, send the same offest 2 times before generating a random offset
  #./run_once.sh OLTP3 4k $SIZE randrw:2 70 30 $QD $CONFIG_FILE
  ./run_once.sh "Random read IOPS" 4k $SIZE randread 100 0 $QD $CONFIG_FILE
  ./run_once.sh "Random write IOPS" 4k $SIZE randwrite 0 100 $QD $CONFIG_FILE
  ./run_once.sh "Random r50/w50 IOPS" 4k $SIZE randrw 50 50 $QD $CONFIG_FILE
  ./run_once.sh "Read BW" 256k $SIZE rw 100 0 $QD $CONFIG_FILE
  ./run_once.sh "Write BW" 256k $SIZE rw 0 100 $QD $CONFIG_FILE
  ./run_once.sh "r50/w50 BW" 256k $SIZE rw 50 50 $QD $CONFIG_FILE

done
mv FIO_OUT* $RUNDIR/.
cd $RUNDIR
./tidy.sh
./analyze.R

