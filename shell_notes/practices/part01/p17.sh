#!/bin/bash
read -p "输入数" p
for ((i=1;i<=$p;i++))
do
  for ((o=$i;o>0;o--))
  do
  echo -n "*"
  done
echo ""
done
