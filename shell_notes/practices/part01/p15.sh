#!/bin/bash
num=(89 76 54 34 23)
len=${#num[*]}
for((i=0;i<${len};i++))
do
  if((num[${i}] < 60))
  then
    unset num[${i}]
  fi
done
echo ${num[*]}

##!/bin/bash
#num=(89 76 54 34 23)
#i=0
#for p in ${num[*]}
# do
# if [ $p -lt 60 ];then
#   unset num[$i]
# fi
#  let i++
#done
#echo ${num[*]}
#~
