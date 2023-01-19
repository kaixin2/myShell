#!/bin/bash
# 为指定用户发送在线信息
username=$1

#  basename 即去除文件名的目录部分和后缀部分，返回一个字符串参数的基本文件名称。
if(($# < 1)); then
  echo "Usage:`basename $0` <username> [<message>]"
  exit 1
fi

# 判断账号是否存在
if grep "^$username:" /etc/passwd &> /dev/null;then :
  else
    echo "用户不存在"
    exit 2
fi
# 判断用户是否在线
until who | grep "$username" &> /dev/null
do
  echo "用户不在线,正在尝试连接"
  sleep 3
done
#传递给脚本或函数的所有参数
# write命令用于传讯息给其他使用者
mes=$*
echo "$mes" | write "$username"