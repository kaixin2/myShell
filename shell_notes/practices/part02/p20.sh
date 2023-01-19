#!/bin/bash
# 修改指定后缀文件的后缀
com="ls ./doc/*.$1"
for i in `${com}`
do
  # Linux mv（英文全拼：move file）命令用来为文件或目录改名、或将文件或目录移入其它位置
  # %.x 将变量内容从后往前符合 .x的最短内容删除
  mv $i ${i%.*}.$2
done

