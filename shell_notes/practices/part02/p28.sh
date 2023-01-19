#!/bin/bash

# 统计 13:30 到 14:30 所有访问本机 Aapche 服务器的远程 IP 地址是什么
# awk 使用‐F 选项指定文件内容的分隔符是/或者:
# 条件判断$7:$8 大于等于 13:30,并且要求,$7:$8 小于等于 14:30
# 日志文档内容里面,第 1 列是远程主机的 IP 地址,使用 awk 单独显示第 1 列即可
awk -F "[ /:]" '"$7:$8">="13:30" && "$7:$8"<="14:30"{print $1}' /var/log/httpd/access_log