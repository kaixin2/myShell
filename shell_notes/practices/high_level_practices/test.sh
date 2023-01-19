#!/bin/bash

check_url(){
  HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)
  if [ ${HTTP_CODE} -eq 200 ]
  then
    # shellcheck disable=SC2104
    continue
  fi
}

USR_LIST="www.baidu.com www.agasgf.com"
for URL in $URL_LIST
do
  check_url $URL
  check_url $URL
  check_url $URL
  echo "Waring: $URL Access failure"
done
