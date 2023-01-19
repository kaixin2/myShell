#!/bin/bash

# 根据 md5 校验码,检测文件是否被修改
# 本示例脚本检测的是/etc 目录下所有的 conf 结尾的文件,根据实际情况,您可以修改为其他目录或文件
# 本脚本在目标数据没有被修改时执行一次,当怀疑数据被人篡改,再执行一次
# 将两次执行的结果做对比,MD5 码发生改变的文件,就是被人篡改的文件
# shellcheck disable=SC2045
for i in $(ls /etc/*.conf)
do
  md5sum "$i" >> /var/log/conf_file.log
done