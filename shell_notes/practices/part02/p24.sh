#!/bin/bash
:<<!
# 编写一个点名器脚本
# 该脚本,需要提前准备一个 user.txt 文件
# 该文件中需要包含所有姓名的信息,一行一个姓名,脚本每次随机显示一个姓名
!
while :
do
  line=`cat ./doc/user.txt | wc -l`
  num=$[RANDOM%${line} +1]
:<<!
  sed 可依照脚本的指令来处理、编辑文本文件。
  -e<script>或--expression=<script> 以选项中指定的script来处理输入的文本文件。
  -f<script文件>或--file=<script文件> 以选项中指定的script文件来处理输入的文本文件。
  -h或--help 显示帮助。
  -n或--quiet或--silent 仅显示script处理后的结果。
  -V或--version 显示版本信息。

  a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
  c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
  d ：删除，因为是删除啊，所以 d 后面通常不接任何东东；
  i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
  p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
  s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正则表达式！例如 1,20s/old/new/g 就是啦！
!
  sed -n "${num}p" ./doc/user.txt
  sleep 0.2
  clear
done