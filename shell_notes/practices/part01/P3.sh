#!/bin/bash
# 创建存放1-100奇数的数组
arr=()
for((i=0;i<=100;i++))
do
  # shellcheck disable=SC2004
  if(($i % 2 == 1))
  then
    # shellcheck disable=SC2034
    arr[($i-1)/2]=$i
  fi
done
echo ${arr[*]}