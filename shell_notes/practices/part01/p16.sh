#!/bin/bash
# 倒直角三角形
read -p "输入数" p
for ((i=1;i<=$p;i++))
do
  for ((o=$i;o<$p;o++))
  do
  echo -n "*"
  done
echo ""
done
