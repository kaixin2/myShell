#!/bin/bash
#chkconfig 35 80 90
echo "设置开机自启"
echo "启动完毕"

cd /etc/init.d/
chmod +x p12.sh

# 添加脚本到开机自动启动项目中
:<<!
Linux chkconfig 命令用于检查，设置系统的各种服务。
这是Red Hat公司遵循GPL规则所开发的程序，它可查询操作系统在每一个执行等级中会执行哪些系统服务，其中包括各类常驻服务。

--add 　增加所指定的系统服务，让 chkconfig 指令得以管理它，并同时在系统启动的叙述文件内增加相关数据。
--del 　删除所指定的系统服务，不再由 chkconfig 指令管理，并同时在系统启动的叙述文件内删除相关数据。
--level<等级代号> 　指定读系统服务要在哪一个执行等级中开启或关毕。
!
chkconfig --add p12.sh
chkconfig p12.sh on

