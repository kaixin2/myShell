#!/bin/bash
read -p "请输入你想要的阶乘" p
jiecheng=1
for ((i=1;i<=$p;i++))
do
  jiecheng=$[jiecheng*i]
done
echo $jiecheng
