#!/bin/bash

# 无法运行,因为本地没有安装yum
if [ $USER == "root" ]
then
	# shellcheck disable=SC1001
	yum ‐y install vsftpd
else
    echo "您不是管理员,没有权限安装软件"
fi

