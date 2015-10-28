#!/bin/bash

INPUT_FILE=BF.job

mkdir -p last
mv BF1.* last/. 

SIZE=4G
mkdir -p current
./config.sh
mv configuration.* current/.
cp analyze.R current/.
cp tidy.sh current/.
for QD in 1 4 16 64  
do
  echo ======= QD=$QD =======
  #./run_once.sh OLTP1 4k $SIZE randrw 60 40 $QD $INPUT_FILE
  #./run_once.sh OLTP2 8k $SIZE randrw 90 10 $QD $INPUT_FILE
  #random read write mix with cache hits, send the same offest 2 times before generating a random offset
  #./run_once.sh OLTP3 4k $SIZE randrw:2 70 30 $QD $INPUT_FILE
  #./run_once.sh "Random read IOPS" 4k $SIZE randread 100 0 $QD $INPUT_FILE
  #./run_once.sh "Random write IOPS" 4k $SIZE randwrite 0 100 $QD $INPUT_FILE
  #./run_once.sh "Random r50/w50 IOPS" 4k $SIZE randrw 50 50 $QD $INPUT_FILE
  ./run_once.sh "Read BW" 256k $SIZE rw 100 0 $QD $INPUT_FILE
  ./run_once.sh "Write BW" 256k $SIZE rw 0 100 $QD $INPUT_FILE
  ./run_once.sh "r50/w50 BW" 256k $SIZE rw 50 50 $QD $INPUT_FILE

done
mv BF1* current/.
cd current
./tidy.sh
./analyze.R

