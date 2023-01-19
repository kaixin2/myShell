#!/bin/bash

read -p "请输入你的成绩" score

case ${score} in
  8[5-9]|9[0-9]|100)
  echo  "成绩优秀"
  ;;
  7[0-9]|8[0-4])
  echo  "成绩良好"
  ;;
  6[0-9])
  echo "成绩合格"
  ;;
esac