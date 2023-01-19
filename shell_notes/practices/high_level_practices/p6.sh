#!/bin/bash
# this shell for analyze CPU by using vmstat which is in package sysstat

DATE=$(date +%F" "%H:%M)
IP=$(ifconfig eth0 | awk -F '[ :]+' '/inet / { print $3}');
# 打印整行
#IP=$(ifconfig eth0 | awk -F '[ :]+' '/inet / { print}');
MAIL="2159289430@qq.com"
if ! which vmstat &>/dev/null
then
    echo "vmstat command no found, Please install procps package."
    exit 1
fi
US=$(vmstat |awk 'NR==3{print $13}')
SY=$(vmstat |awk 'NR==3{print $14}')
IDLE=$(vmstat |awk 'NR==3{print $15}')
WAIT=$(vmstat |awk 'NR==3{print $16}')
USE=$(($US+$SY))

if [ $USE -ge 2 ]
then
  echo "
  Date: $DATE
  Host: $IP
  Problem: CPU utilization $USE
  " | mail -s "CPU Monitor" $MAIL
  # mail 邮件发送功能有问题
fi
