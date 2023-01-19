#!/bin/bash
num=(90 90 90 90 90 90 90 90 20 20)
for((i=0;i<=9;++i))
do
  # shellcheck disable=SC2004
  if((num[${i}]<60))
  then
    num[${i}]=60
  fi
done
echo ${num[*]}