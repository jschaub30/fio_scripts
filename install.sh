#!/bin/bash

OS=CENTOS

which yum
[ $? -ne 0 ] && OS=UBUNTU

echo $OS detected

echo ==== Installing linux packages ====
if [ $OS == "CENTOS" ]; then
  sudo yum install epel-release -y
  sudo yum update
  sudo yum install fio dstat sysstat htop -y
  sudo yum install R
fi
if [ $OS == "UBUNTU" ]; then
  sudo apt-get install epel-release -y
  sudo apt-get update
  sudo apt-get install fio dstat sysstat htop -y
  sudo apt-get install r-base
fi

echo ==== Installing R packages ====
sudo su - -c "R -e \"install.packages('ggplot2', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('reshape2', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('dplyr', repos='http://cran.rstudio.com/')\""
