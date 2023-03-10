#!/bin/bash

# 1.读入数据,read从控制台读入一行数据
#read a
#read b
#echo ${a}
#echo ${b}

# 2.输出不换行
#echo -n "123"
#echo "123"
#echo -e "OK! \c" # -e 开启转义 \c 不换行
#echo "It is a test"

# 3.显示结果定向至文件
#echo "It is a test" > myfile

# 4.显示命令执行结果
#echo `date`

# 5.格式化输出
#printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg
#printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234
#printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543
#printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876


# format-string为双引号
printf "%d %s\n" 1 "abc"
# 单引号与双引号效果一样
printf '%d %s\n' 1 "abc"
# 没有引号也可以输出
printf %s abcdef
printf "\n"
# 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
printf %s abc def
printf "%s\n" abc def
printf "%s %s %s\n" a b c d e f g h i j
# 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
printf "%s and %d \n"