#!/bin/bash
#统计每个远程ip访问了本机apache多少次
#BEGIN{ 这里面放的是执行前的语句 }
#END {这里面放的是处理完所有的行后要执行的语句 }
awk '{ip[$1]++}END{for(i in ip){print ip[i],i}}' /var/log/httpd/access_log