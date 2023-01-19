#!/bin/bash

for i in {1..9}
do
  for((j=1;j<=$i;j++))
  do
    echo -n "$i * $j = $(($i * $j)) "
    done
  echo
  done