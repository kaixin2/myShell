#!/bin/bash

# 循环ping192.168.110网段的所有主机
i=1
pre=www.baidu.com
pre=192.168.0
for i in {1..5}
do

:<<!
  -c <完成次数> 设置完成要求回应的次数。
  -w <deadline> 在 deadline 秒后退出。
  -i<间隔秒数> 指定收发信息的间隔时间。
!
#  ping ${pre} > /dev/null
  ping -c 2 -w 3 -i 0.3 ${pre}."${i}" > /dev/null
  # shellcheck disable=SC2181
#  if [ $? -eq 0 ]  # 必须和[]符号间隔空格,不然就是语法错误
  if(($? == 0))
  then
     echo "${pre}.$i is yes"
  else
   echo "${pre}.$i is no"
  fi
#  let 命令是 BASH 中用于计算的工具，用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量。如果表达式中包含了空格或其他特殊字符，则必须引起来。
#  let i++
done