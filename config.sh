#!/bin/bash

mkdir -p last
mv configuration.* last/.
uname -a > configuration.uname
lsb_release -a > configuration.lsb
dmesg | grep -i emulex > configuration.driver
