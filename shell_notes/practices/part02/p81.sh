#!/bin/bash

user=$(awk -F: '$3>=1000{print $1}' /etc/passwd)

for i in $user
do
  userdel -r $i
done