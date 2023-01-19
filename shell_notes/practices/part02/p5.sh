#!/bin/bash
# 实时监控本机内存和硬盘剩余空间,剩余内存小于500M、根分区剩余空间小于1000M时,发送报警邮件给root管理员

#  df（英文全拼：disk free） 命令用于显示目前在 Linux 系统上的文件系统磁盘使用情况统计。
# df / 显示磁盘上使用的文件系统信息 df . 也是同样的功能

#  $( )与（反引号）都是用来作命令替换的。

# awk 是一种处理文本文件的语言，是一个强大的文本分析工具 使用正则匹配内容(/内容/)后按空格或Tab进行分割,输出分隔后的第4项
# 叫 AWK 是因为其取了三位创始人 Alfred Aho，Peter Weinberger, 和 Brian Kernighan 的 Family Name 的首字符。
# -F, 指定分割符号为,
disk_size=$(df / | awk '/\//{print $4}')
# free指令会显示内存的使用情况，包括实体内存，虚拟的交换文件内存，共享内存区段，以及系统核心使用的缓冲区等
mem_size=$(free | awk '/Mem/{print $4}')
while :
do
  if [ $disk_size -le 51200 -a $mem_size -le 1024000 ]
  then
    mail -s "warning" root <<EOF
      Insufficient resources,资源不足
EOF
  fi
done