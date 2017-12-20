# fio_scripts
These scripts run the [fio](https://linux.die.net/man/1/fio) utility for testing IO
subsystems across a variety of read/write scenarios and queue depths.  While
running each workload, the following measurement utilities collect data:
- [dstat](http://dag.wiee.rs/home-made/dstat/)
- [vmstat](https://linux.die.net/man/8/vmstat)
- [iostat](https://linux.die.net/man/1/iostat)

After all the workloads complete, an [R](https://www.r-project.org/) script
processes a subset of the data to produce SVG plots for bandwidth and IOPS.

Tested in Ubuntu and Centos.

SETUP
=====
```
git clone https://github.com/jschaub30/fio_scripts
cd fio_scripts/
./install.sh
```

USAGE
=====
- (Optional) Edit the "config.job" file.
- (Optional) Edit the "collect.sh" script to change the sweep parameters

To collect the raw data:
-----------------------
```
./collect.sh [path/to/file2test]
```
To view the results, change to the 'last' directory (a soft-link) and open the
index.html file in your browser.
```
cd last
firefox index.html
```
