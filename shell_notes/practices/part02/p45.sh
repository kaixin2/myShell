#!/bin/bash

# 检查特定的软件包是否已经安装
if [ $# -eq 0 ];then
  echo "你需要制定一个软件包名称作为脚本参数"
  echo "用法:$0 软件包名称 ..."
fi
# $@提取所有的位置变量的值,相当于$*
for package in "$@"
do
    if rpm -q ${package} &>/dev/null ;then
    echo -e "${package}\033[32m 已经安装\033[0m"
    else
    echo -e "${package}\033[34;1m 未安装\033[0m"
    fi
done