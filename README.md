# fio_scripts
Scripts for testing IO subsystems using the fio utility

SETUP
=====

To collect the raw data
-----------------------
apt-get install fio

To generate the output plots
----------------------------
```sudo apt-get install r-base```

Launch R
```sudo R```
In the r-shell, run the following commands
```
install.packages('ggplot2')
install.packages('reshape2')
install.packages('dplyr')
```

USAGE
=====
Edit the "config.job" file.  In particular, change the "filename" field to point
to the target IO location.

Edit the "run_fio.sh" script and un-comment the tests you wish to run
Run the tests:
```./run_fio.sh```
