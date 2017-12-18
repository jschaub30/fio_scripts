# fio_scripts
Scripts for testing IO subsystems using the fio utility

SETUP
=====
```
./install.sh
```

USAGE
=====
Edit the "config.job" file.  In particular, change the "filename" field to point
to the target IO location.

Edit the "run_fio.sh" script and un-comment the tests you wish to run.

To collect the raw data:
-----------------------
```
./run_fio.sh
```
