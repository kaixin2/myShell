#!/bin/bash
# 备份日志
# 每周 5 使用 tar 命令备份/var/log 下的所有日志文件
# vim  /root/logbak.sh
# 编写备份脚本,备份后的文件名包含日期标签,防止后面的备份将前面的备份数据覆盖
# 注意 date 命令需要使用反引号括起来,反引号在键盘<tab>键上面

:<<!
Linux tar（英文全拼：tape archive ）命令用于备份文件。
tar 是用来建立，还原备份文件的工具程序，它可以加入，解开备份文件内的文件

-c或--create 建立新的备份文件
-f<备份文件>或--file=<备份文件> 指定备份文件。
-z或--gzip或--ungzip 通过gzip指令处理备份文件。
!
tar -czf log-`date +%Y%m%d`.tar.gz /var/log
# crontab ‐e  #编写计划任务,定时执行备份脚本
00 03 * * 5 /root/logbak.sh