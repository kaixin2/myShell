#!/bin/bash
s0=`cat ./doc/name.txt | grep "shangzhen"`
s1=`cat ./doc/name.txt | grep "shengjie" `
s2=`cat ./doc/name.txt | grep "shanannan"`
a=0
b=0
c=0
for ((i=1;i<=10;i++))
do
  suiji=$[$RANDOM%3]
  if [ $suiji -eq 0 ];then
    a=$[$a+1]  # 是用来作数字运算的
   echo "$s0的票数为$a"

  elif   [ $suiji -eq 1 ];then
    b=$[$b+1]
   echo "$s1的票数为$b"
  elif   [ $suiji -eq 2 ];then
    c=$[$c+1]
   echo "$s2的票数为$c"
   fi
done
echo $a $b $c
