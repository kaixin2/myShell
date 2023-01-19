#!/bin/bash

# 1.只读字符

#readonly your_name="kaixin"
#echo ${your_name}
#your_name="change"
#echo ${your_name}


#2.删除变量

#myUrl="https://www.runoob.com"
#echo $myUrl
#unset myUrl # 删除变量
#echo $myUrl


#3. 双引号

#your_name="runoob"
#greeting="hello, "$your_name" !"
#greeting_1="hello, ${your_name} !"
#echo $greeting  $greeting_1


#4.单引号
#单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
#单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

#greeting_2='hello, '${your_name}' !'
#greeting_3='hello, ${your_name} !'
#echo ${greeting_2}
#echo ${greeting_3}


#5.获取字符串长度
#
#string="abcd"
#echo ${#string}

#6. 截取子字符串 第一个字符的索引值为 0
#string="runoob is a great site"
#echo ${string:0:4} # 输出runo

#7. 查找字符串
#string=" grea"
#echo `expr index "${string}" ' '`  # 输出 4

#8. 数组
#sh支持一维数组（不支持多维数组），并且没有限定数组的大小。
#类似于 C 语言，数组元素的下标由 0 开始编号。获取数组中的元素要利用下标，下标可以是整数或算术表达式，其值应大于或等于0
array_name=(value0 value1 value2 value3)
#inde=5
#arr[${inde}]=1
#echo ${arr[inde]}
#echo ${array_name[1]}

# 获取数组中所有元素
echo ${array_name[*]}
echo ${#array_name[*]}