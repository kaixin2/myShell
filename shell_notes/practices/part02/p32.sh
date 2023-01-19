#!/bin/bash
cd ./doc
sum=0
for i in `ls -r *`
do
  if [ -f $i ];then
    let sum++
    echo "文件名: $i"
  fi
done
echo "文件总数量:$sum"