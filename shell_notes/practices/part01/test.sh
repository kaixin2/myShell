#!/bin/bash
function rand(){
  temp=5
  echo $(($RANDOM + 1000))
}

function main(){
#    echo $(rand)
  echo "hello"
}
main
#echo ${temp}