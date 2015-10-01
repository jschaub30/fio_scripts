#!/bin/bash

echo "test,queue_depth,read_bw_k,read_iops,write_bw_k,write_iops" > output.csv
egrep "TEST|fio" BF1.fio | cut -d';' -f7-8,48-49 | perl -pe \
  "s/(\d+);(\d+);(\d+);(\d+)/\1,\2,\3,\4/" | perl -pe \
  "s/^======= TEST: (.*)_q(\d+) =======\n/\1,\2,/" >> output.csv

