#!/bin/bash

# 生成指定范围内的随机数
function rand() {
    min=$1;
    max=$(($2 - $min + 1));
    num=$(($RANDOM + 1000000000));
    echo $(($num%$max+$min))
}

num=$(rand 1 100)
echo $num



# 猜数字游戏
while :
do
  # shellcheck disable=SC2162
  # -p 后面跟提示信息，即在输入前打印提示信息
  read -p "计算机生成了一个 1-100的随机数,你猜: " cai
  echo ${num}
  if(($cai==$num))
  then
    echo "恭喜你,猜对了"
    exit
   elif (($cai>$num))
   then
    echo "Oops 猜大了"
   else
     echo "Oops 猜小了"
  fi
done