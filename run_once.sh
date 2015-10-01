#!/bin/bash

usage(){
 echo USAGE ./run_once.sh NAME BLOCK_SIZE FILE_SIZE IO_TYPE MIXREAD MIXWRITE QD JOB_FILE
 exit 1
}
[ $# -ne 8 ] && usage
NAME=$1
export BLOCK_SIZE=$2
export FILE_SIZE=$3
export IO_TYPE=$4
export MIXREAD=$5
export MIXWRITE=$6
export QD=$7
JOB_FILE=$8

OUTPUT=BF1

FIO="fio --minimal"	 #fio's REAL_MAX_JOBS limit is 2048

echo "Starting $NAME Test"
CONFIG=$(echo "======= TEST: ${BLOCK_SIZE}_r${MIXREAD}_w${MIXWRITE}_q${QD} =======")
echo $CONFIG >> $OUTPUT.fio
echo $CONFIG >> $OUTPUT.dstat
echo $CONFIG >> $OUTPUT.iostat
echo $CONFIG >> $OUTPUT.vmstat

DELAY=3
dstat -drcgynp --aio --fs -t $DELAY        >> $OUTPUT.dstat    & 
PID[1]=$!
iostat -txm $DELAY                         >> $OUTPUT.iostat   &
PID[2]=$!
vmstat -w $DELAY                           >> $OUTPUT.vmstat   &
PID[3]=$!

sleep 5 
echo `date` ": RUN STARTED" >> $OUTPUT.fio

#cmd="BLOCK_SZ=$BLOCK_SIZE IOT=$IO_TYPE SIZE=$SIZE Qdepth=$QD \
     #MIXREAD=$MIXREAD MIXWRITE=$MIXWRITE $FIO $JOB_FILE"
echo Running fio
$FIO $JOB_FILE >> $OUTPUT.fio 2>&1
sleep 5
kill ${PID[*]}

