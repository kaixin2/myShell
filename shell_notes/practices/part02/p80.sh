#!/bin/bash

# 显示本机 Linux 系统上所有开放的端口列表

# 从端口列表中观测有没有没用的端口,有的话可以将该端口对应的服务关闭,防止意外的攻击可能性
:<<!
命令参数：
-h, --help 帮助信息
-V, --version 程序版本信息
-n, --numeric 不解析服务名称
-r, --resolve        解析主机名
-a, --all 显示所有套接字（sockets）
-l, --listening 显示监听状态的套接字（sockets）
-o, --options        显示计时器信息
-e, --extended       显示详细的套接字（sockets）信息
-m, --memory         显示套接字（socket）的内存使用情况
-p, --processes 显示使用套接字（socket）的进程
-i, --info 显示 TCP内部信息
-s, --summary 显示套接字（socket）使用概况
-4, --ipv4   仅显示IPv4的套接字（sockets）
-6, --ipv6   仅显示IPv6的套接字（sockets）
-0, --packet 显示 PACKET 套接字（socket）
-t, --tcp 仅显示 TCP套接字（sockets）
-u, --udp 仅显示 UCP套接字（sockets）
-d, --dccp 仅显示 DCCP套接字（sockets）
-w, --raw 仅显示 RAW套接字（sockets）
-x, --unix 仅显示 Unix套接字（sockets）
!
ss -nutlp | awk '{print $1,$5}'  | grep "[0‐9]" | uniq
#| awk -F"[: ]" '{print "协议:"$1,"端口号:"$NF}'