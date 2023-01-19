#!/bin/bash
# this shell to execute curl order
check_url(){
  HTTP_CODE=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)
  if [ "${HTTP_CODE}" -eq 200 ]
  then
    # shellcheck disable=SC2104
     echo "successful"
  else
      echo "fail"
  fi
}

URL_LIST="www.baidu.com www.agasgf.com"
# shellcheck disable=SC2153
for URL in $URL_LIST
do
  RES=$(check_url "$URL")
  echo "${RES}"
done
