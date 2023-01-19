#!/bin/bash

FILE="./static/user.txt"
#command > file	将输出重定向到 file
#command < file	将输入重定向到 file
#command >> file	将输出以追加的方式重定向到 file
#n > file	将文件描述符为 n 的文件重定向到 file
#n >> file	将文件描述符为 n 的文件以追加的方式重定向到 file
#n >& m	将输出文件 m 和 n 合并
#n <& m	将输入文件 m 和 n 合并
#<< tag	将开始标记 tag 和结束标记 tag 之间的内容作为输入

#echo "这些东西可真好啊" > ${FILE}
#cat ${FILE}
#echo "菜鸟教程：www.runoob.com" > ${FILE}

# 1.统计文件中内容行数, 会输出行数和文件名
#wc -l ${FILE}

# 2.从文件中读取内容,只输出读取行数,不会输出文件名
# wc用于统计文本文件的行数、单词数和字节数
# -c 显示文件的Bytes数(字节数)
# -l 将每个文件的行数及文件名输出到屏幕上
# -m 将每个文件的字符数及文件名输出到屏幕上,如果当前系统不支持多字节字符其将显示与-c参数相同的结果
# -w 将每个文件含有多少个词及文件名输出到屏幕上
#wc -l < ${FILE}
#wc -w ${FILE}




