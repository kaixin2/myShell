#!/bin/bash
# this shell check  service status
 # -a 全部套接字状态, -u UDP -c 123 指定列数
 PORT_C=$(ss -anu | grep -c 123)
 # -e：等价于 ‘-A’ ，表示列出全部的进程
 #-f：显示全部的列（显示全字段）
 PS_C=$(ps -ef | grep ntpd | grep -vc grep)