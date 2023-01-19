#!/bin/bash
# 冒泡排序
arr=(53 100 86 92 86 55 65 76 56 59)

len=${#arr[*]}
for((i=0;i<$len;i++))
do
  for((j=0;j<$len-i;j++)){
    if((${arr[j + 1]} < ${arr[j]}))
    then
      te=${arr[j + 1]}
      arr[j + 1]=${arr[j]}
      arr[j]=$te
    fi
}
done
echo ${arr[*]}

