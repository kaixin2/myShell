#!/bin/bash
# Ababa Ababa
# coTU4sJHjcWD1LLJakUhrA== encrypt_str

#KEY="E05A84ED2068B3DEE402304AD12F4A40"
IV="E27DCFC8DF33FA58E335BEBB5978B7B4"

#解密
function my_decrypt() {
    echo "$1" | openssl enc -d -aes-128-cbc -a -k $2 -iv $IV -iter 10 2> /dev/null

}
##加密
#function my_encrypt() {
#    echo "$1" | openssl enc -e -aes-256-cbc -a  -iv ${IV} -k $2
#}


#key="9Ababa"
#encrypt_str="U2FsdGVkX1/3TcZM3beo8aubUSRZHmKN1hCRuOTY4Ps="
#decrypt_str=$(my_decrypt ${encrypt_str} ${key})
#echo $?

declare -A map
map["mail"]=12
str=${map["mail"]}
echo ${#str}
str=${map["mail1"]}
echo ${#str}
#echo ${decrypt_str}


#FILE="./test.txt"
#for e in $(cat $FILE)
#do
#  echo $e
#done