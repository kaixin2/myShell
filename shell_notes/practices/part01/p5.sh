#!/bin/bash
#计算数组中的最大值

# shellcheck disable=SC2034
score=(72 63 90 415 75)
temp=0
for((i=0;i<${#score[*]};i++))
do
  if(($temp<${score[$i]}))
  then
  temp=${score[$i]}
  fi
done
echo $temp