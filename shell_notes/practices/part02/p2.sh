#!/bin/bash
# 创建用户
useradd "$1"
echo "$2" | passwd --stdin "$1"

