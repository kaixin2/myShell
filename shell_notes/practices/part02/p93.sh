#!/bin/bash

tm=$(date +%H)
if [ $tm -le 12 ];then
  msg="Good Morning $USER"
elif [ $tm -gt 12 -a $tm -le 18 ]; then
  msg="Good Afternoon $USER"
else
  msg="Good Night $USER"
fi
echo "当前时间是: $(date +"%Y-%m-%d %H:%M:%S")"
echo -e "\033[34m$msg\033[0m"