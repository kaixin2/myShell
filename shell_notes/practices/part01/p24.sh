#!/bin/bash
if(($# != 3)) ; then
  echo "`basename $0` part1 part2 part3"
  exit
fi
fun3(){
  echo $[ $1 * $2 * $3]
}
fun3 $1 $2 $3
