#!/bin/bash
# this shell check ping status

IP_LIST="192.168.18.1 192.168.1.1 192.168.18.2"
for IP in ${IP_LIST}
do
  NUM=1
  while ($NUM < 3)
    do
      if ping -c 1 $IP >/dev/null
      then
         echo "$IP Ping is successful"
         break
       else
         FAIL_COUNT[$NUM]=$IP
         # shellcheck disable=SC2219
         let NUM++
      fi
    done
  if [ ${#FAIL_COUNT[*]} -eq 3 ]
  then
    echo "${FAIL_COUNT[1]} Ping is failure"
    unset FAIL_COUNT[*]
  fi
done
