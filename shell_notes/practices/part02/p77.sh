#!/bin/bash

# 显示进度条(数字版)
# echo 使用‐e 选项后,在打印参数中可以指定 H,设置需要打印内容的 x,y 轴的定位坐标
# 设置需要打印内容在第几行,第几列
for i in {1..100}
do
    echo -e "\033[6;8H["
    echo -e "\033[6;9H$i%"
    echo -e "\033[6;13H]"
    sleep 0.1
done