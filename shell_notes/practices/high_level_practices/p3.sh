#!/bin/bash

# this shell check package has installed or not
name=$1
if rpm -q "${name}" &>dev/null
then
  echo "${name} is already installed"
else
  echo "${name} is not installed"
fi
