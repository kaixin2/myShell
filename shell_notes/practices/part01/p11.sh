#!/bin/bash
#chkconfig: 35 80 90
#开机启动ip地址调整
ip=www.baidu.com

ping -c 2 $ip &>/dev/null
if  [ $? -eq 0 ]
 then
echo "百度没问题"
 else
 echo "请主人稍等，我正在更改你的网卡"
:<<!
sed 命令是利用脚本来处理文本文件。
sed 可依照脚本的指令来处理、编辑文本文件。
Sed 主要用来自动编辑一个或多个文件、简化对文件的反复操作、编写转换程序等。

a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
d ：删除，因为是删除啊，所以 d 后面通常不接任何东东；
i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正则表达式！例如 1,20s/old/new/g
r : 使用扩展正则表达式

/^IPADDR=/c 匹配该行 替换为之后的内容
!
sed -ri '/^IPADDR=/cIPADDR=192.168.110.132' /etc/sysconfig/network-scripts/ifcfg-ens33
sed -ri '/^GATEWAY=/cGATEWAY=192.168.110.2' /etc/sysconfig/network-scripts/ifcfg-ens33
sed -ri '/^DNS1=/cDNS1=8.8.8.8' /etc/sysconfig/network-scripts/ifcfg-ens33
echo "网卡配置文件已改完  正在重启网络服务"
systemctl restart network
fi

ping -c 2 $ip &>/dev/null
if [ $? -eq 0 ] ;then
 echo "主人，一切准备就绪"
 else
  echo "请检查你绑定的网卡是不是vm8"
fi
