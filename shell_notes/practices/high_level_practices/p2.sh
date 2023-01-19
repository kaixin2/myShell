#!/bin/bash
# this shell for add user bulk

# 带颜色打印文字信息
echo_color(){
    if [ "$1" == "green" ]; then
        echo -e "\033[32;40m$2\033[0m"
    elif [ "$1" == "red" ]; then
        echo -e "\033[31;40m$2\033[0m"
    fi
}
# %F   完整的日期；等价于 %Y-%m-%d  %T   时间; 等价于 %H:%M:%S
DATE=$(date +%F_%T)

:<<!
其实${}并不是专门为提取文件名或目录名的，它的使用是变量的提取和替换等等操作，
它可以提取非常多的内容，并不一定是上面五个例子中的’/‘或’.’。也就是说，上面的使用方法只是它使用的一个特例。
看到上面的这些命令，可能会让人感到非常难以理解和记忆，其实不然，它们都是有规律的。
#：表示从左边算起第一个
%：表示从右边算起第一个
##：表示从左边算起最后一个
%%：表示从右边算起最后一个
换句话来说，＃总是表示左边算起，％总是表示右边算起。
＊：表示要删除的内容，对于#和##的情况，它位于指定的字符（例子中的’/‘和’.’）的左边，
表于删除指定字符及其左边的内容；对于%和%%的情况，它位于指定的字符（例子中的’/‘和’.’）的右边，
表示删除指定字符及其右边的内容。这里的’'的位置不能互换，即不能把号放在#或##的右边，反之亦然。
例如：${var%%x*}表示找出从右边算起最后一个字符x，并删除字符x及其右边的字符。
看到这里，就可以知道，其实该命令的用途非常广泛，上面只是指针文件名和目录名的命名特性来进行提取的一些特例而已。
!

USER_FILE=./doc/user.txt
PRE_NEME=${USER_FILE%.*}
#[ -f FILE ]  如果 FILE 存在且是一个普通文件则为真。
#[ -s FILE ]  如果 FILE 存在且大小不为0则为真
if [ -s "${USER_FILE}" ]
then
#   目标目录与原目录一致，指定了新文件名，效果就是仅仅重命名。
# 目标目录与原目录不一致，没有指定新文件名，效果就是仅仅移动。
  mv ${USER_FILE} ${PRE_NEME}_${DATE}.bak
  echo_color green "${USER_FILE} exist, rename ${PRE_NEME}_${DATE}.bak"
fi

# echo -e 将转义后的内容输出到屏幕
echo -e "USER\tPassword" >> $USER_FILE
echo "------------------" >> $USER_FILE

for USER in user{1..10}
do
  if ! id $USER &>/dev/null
  then
    PASS=$(echo $RANDOM | MD5SUM | CUT -c 1-8)
#    useradd 可用来建立用户帐号。帐号建好之后，再用 passwd 设定帐号的密码。
# passwd  --stdin $name是更改$name变量的密码 从标准输入管道读入新的密码。
    useradd $USER
    echo $PASS |passwd --stdin $USER &>/dev/null
    echo -e "$USER\t$PASS" >> $USER_FILE
    echo "$USER User create successful."
  else
    echo_color red "$USER USER ALREADY EXISTS!"
  fi
done