#!/bin/bash

# 显示当前计算机中所有账户的用户名称

# 下面使用3种不同的方式列出计算机中所有账户的用户名
# 指定以:为分隔符,打印/etc/passwd 文件的第 1 列
awk -F: '{print $1}' /etc/passwd

# 指定以:为分隔符,打印/etc/passwd 文件的第 1 列

#Linux cut命令用于显示每行从开头算起 num1 到 num2 的文字。
#-d ：自定义分隔符，默认为制表符。
#-f ：与-d一起使用，指定显示哪个区域。
cut -d: -f1 /etc/passwd

# 使用 sed 的替换功能,将/etc/passwd 文件中:后面的所有内容替换为空(仅显示用户名)
sed 's/:.*//' /etc/passwd