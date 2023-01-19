#!/bin/bash

# 查找 Linux 系统中的僵尸进程
# awk 判断 ps 命令输出的第 8 列为 Z 是,显示该进程的 PID 和进程命令
# -aux 显示所有包含其他使用者的进程
ps aux | awk '{if($8 == "Z") {print $2,$11}}'