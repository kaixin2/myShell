#!/bin/bash

# 非交互自动生成 SSH 密钥文件
# ‐t 指定 SSH 密钥的算法为 RSA 算法;‐N 设置密钥的密码为空;‐f 指定生成的密钥文件>存放在哪里
rm  -rf  ~/.ssh/{known_hosts,id_rsa*}
# shellcheck disable=SC1001
ssh-keygen -t RSA -N '' -f ~/.ssh/id_rsa