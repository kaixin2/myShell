#!/bin/bash
num=()
arr(){
  path="./doc/text1.txt"
  read -p "请输入你想加入的元素: " n
  echo $n >> ${path}
  list=`cat ${path}`
  num=($list)
  echo "数组中的元素: ${num[*]}"
}

while :
do
  read -p "请问你想要加入元素吗? [Y/N]: " add
  if [ "$add" = "Y" ]  # 字符串比较符号和数字比较符号不同, 且字符串比较不能使用()
    then
      arr
  elif [ "$add" = "N" ]
    then
      echo "数组中所有的元素为: ${num[*]},再见"
  fi
done
