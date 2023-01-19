#!/bin/bash

menu(){
  clear
  echo "  ##############‐‐‐‐Menu‐‐‐‐##############"
  echo "# 1. Install Nginx"
  echo "# 2. Install MySQL"
  echo "# 3. Install PHP"
  echo "# 4. Exit Program"
  echo "  ########################################"
}
choice(){
  read -p "please choice menu[1-9]:" select
}
:<<!
Linux id命令用于显示用户的ID，以及所属群组的ID。
id会显示用户以及所属群组的实际与有效ID。若两个ID相同，则仅显示实际ID。若仅指定用户名称，则显示目前用户的ID。
!
install_nginx(){
  id nginx &> /dev/null
  if [ $? -ne 0 ]; then
    useradd -s /sbin/nologin nginx
  fi

  # 如果当前目录下指定文件存在
:<<!
1、源码安装一般包括几个步骤：配置（configure），编译（make），安装（make install）。
2、其中configure是一个可执行脚本，在源码目录中执行可以完成自动的配置工作，即./configure。
3、在实际的安装过程中，我们可以增加--prefix参数，这样可以将要安装的应用安装到指定的目录中，如，我们要安装git应用，在配置环节可以使用如下命令：
!
  if [ -f nginx‐1.8.0.tar.gz ];then
    tar -xf nginx‐1.8.0.tar.gz
    cd nginx-1.8.0
    # 选项包括-h（帮助），-y（当安装过程提示选择全部为 "yes"），-q（不显示安装的过程
    yum -y install  gcc pcre‐devel openssl‐devel zlib‐devel make
    ./configure ‐‐prefix=/usr/local/nginx ‐‐with‐http_ssl_module
    make
    # 安装已经编译好的程序
    make install
    ln -s /usr/local/nginx/sbin/nginx /usr/sbin/
    cd ..
  else
    echo "没有 Nginx 源码包"
  fi
}

install_mysql(){
  yum -y install gcc gcc-c++ cmake ncurses-devel perl
  id mysql &>/dev/null
  if [ $? -ne 0 ];then
    useradd -s /sbin/nologin mysql
  fi
   if [ -f mysql‐5.6.25.tar.gz ];then
    tar -xf mysql‐5.6.25.tar.gz
    cd mysql‐5.6.25
    cmake .
    make
    make install
    /usr/local/mysql/scripts/mysql_install_db ‐‐user=mysql ‐‐datadir=/usr/local/mysql/data/
    ‐‐basedir=/usr/local/mysql/

:<<!
  chown（英文全拼：change owner）命令用于设置文件所有者和文件关联组的命令。
  user : 新的文件拥有者的使用者 ID
  group : 新的文件拥有者的使用者组(group)
  -c : 显示更改的部分的信息
  -f : 忽略错误信息
  -h :修复符号链接
  -v : 显示详细的处理信息
  -R : 处理指定目录以及其子目录下的所有文件
  --help : 显示辅助说明
  --version : 显示版本
!
    # 将/usr/local/mysql下的所有文件与子目录的拥有者皆设为Root.mysql
    chown -R root.mysql /usr/local/mysql
    chown -R mysql /usr/local/mysql/data
    /bin/cp -f /usr/local/mysql/support‐files/mysql.server /etc/init.d/mysqld

    chmod +x /etc/init.d/mysqld
    /bin/cp -f /usr/local/mysql/support‐files/my‐default.cnf /etc/my.cnf
    echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf

:<<!
  主要是在默认搜寻目录/lib和/usr/lib以及动态库配置文件/etc/ld.so.conf内所列的目录下，搜索出可共享的动态链接库（格式如lib*.so*）,
  进而创建出动态装入程序(ld.so)所需的连接和缓存文件，缓存文件默认为/etc/ld.so.cache，此文件保存已排好序的动态链接库名字列表。
!
    idconfig
    echo 'PATH=\$PATH:/usr/local/mysql/bin/' >> /etc/profile
    export PATH
  else
    echo  "没有 mysql 源码包"
    exit
  fi
}


install_php()
{
#安装 php 时没有指定启动哪些模块功能,如果的用户可以根据实际情况自行添加额外功能如‐‐with‐gd 等
yum  -y  install  gcc  libxml2‐devel
if [ -f mhash‐0.9.9.9.tar.gz ];then
  tar -xf mhash‐0.9.9.9.tar.gz
  cd mhash‐0.9.9.9
  ./configure
  make
  make install
  cd ..
if [ ! ‐f /usr/lib/libmhash.so ];then
  ln -s /usr/local/lib/libmhash.so /usr/lib/
fi
ldconfig
else
  echo "没有 mhash 源码包文件"
  exit
fi
if [ -f libmcrypt‐2.5.8.tar.gz ];then
  tar -xf libmcrypt‐2.5.8.tar.gz
  cd libmcrypt‐2.5.8
  ./configure
  make
  make install
  cd ..
  if [ ! -f /usr/lib/libmcrypt.so ];then
    ln -s /usr/local/lib/libmcrypt.so /usr/lib/
  fi
  ldconfig
else
  echo "没有 libmcrypt 源码包文件"
  exit
fi
if [ -f php‐5.4.24.tar.gz ];then
  tar -xf php‐5.4.24.tar.gz
  cd php‐5.4.24
  ./configure  ‐‐prefix=/usr/local/php5  ‐‐with‐mysql=/usr/local/mysql  ‐‐enable‐fpm    ‐‐
  enable‐mbstring  ‐‐with‐mcrypt  ‐‐with‐mhash  ‐‐with‐config‐file‐path=/usr/local/php5/etc  ‐‐with‐
  mysqli=/usr/local/mysql/bin/mysql_config
  make && make install
  /bin/cp -f php.ini‐production /usr/local/php5/etc/php.ini
  /bin/cp -f /usr/local/php5/etc/php‐fpm.conf.default /usr/local/php5/etc/php‐fpm.conf
  cd ..
else
  echo "没有 php 源码包文件"
  exit
fi
}

while :
do
  menu
  choice
  case $select in
  1)
    install_nginx
    ;;
  2)
    install_mysql
    ;;
  3)
    install_php
    ;;
  4)
    exit
    ;;
  *)
    echo Sorry!
  esac
