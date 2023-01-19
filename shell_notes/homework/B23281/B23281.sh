#!/bin/bash

FILE=test/test.out
function main() {

  if [[ -f $FILE ]]
  then
    echo "exist"
  else
    echo "no"
  fi


}

main