#!/bin/bash

# 显示进度条(回旋镖版)

while :
do
  clear
  for i in {1..20}
  do
    echo -e "\033[3;${i}H*"
    sleep 0.1
  done
  clear
  for i in {20..1}
    do
    echo -e "\033[3;${i}H*"
    sleep 0.1
    done
    clear
done