#!/bin/bash
# for循环批量创建用户
# shellcheck disable=SC2006
user=$`cat /opt/user.txt`
for i in ${user}
do
  useradd "$i"
:<<!
1. 将echo "1234"的结果通过管道'|',输入到  命令 (passwd -- stdin)中
2. passwd命令用来更改使用者的密码  "$i"表示要修改密码的用户, --stdin 表示要修改的密码从 --stdin中获取
!
  echo "1234" | passwd --stdin "$i"
done