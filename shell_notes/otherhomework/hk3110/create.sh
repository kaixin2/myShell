#!/bin/bash
#This script is used to generate cipher text, when executing this script, 2 parameters are required [plaintext][ciphertext].
KEY="E05A84ED2068B3DEE402304AD12F4A40"
IV="E27DCFC8DF33FA58E335BEBB5978B7B4"
function my_encrypt() {
    if test -z $3; #If the request is explicitly not filled
    then
        echo "$1" | openssl enc -e -aes-128-cbc -a -k $2 -iv $IV -iter 10 2> /dev/null
    else
      # Without any padding, it is required that the plaintext must be an integer multiple of 16 bytes.
       echo "$1" | openssl enc -e -aes-128-cbc -a -k $2 -iv $IV -nopad -iter 10
    fi

}

SOURCE_STR=$1
KEY=$2
if test -z $3;
then
   echo $(my_encrypt ${SOURCE_STR} ${KEY})
else
   echo $(my_encrypt ${SOURCE_STR} ${KEY} "np")
fi
# padding
# INPUT: Ababa 9Ababa
# OUTPUT: U2FsdGVkX18tkm0ZBzIZbeMDu29+nyJL92YyV2ZBUsU=
# ./create.sh Ababa 9Ababa

## no padding
# INPUT: AbabaAbabaAbabaA 9AbabaAbabaAbaba
# OUTPUT: U2FsdGVkX18tkm0ZBzIZbeMDu29+nyJL92YyV2ZBUsU=
# ./create.sh 9AbabaAbabaAbab 9Ababa np


#
#bad decrypt
#9008:error:0607F08A:digital envelope routines:EVP_EncryptFinal_ex:data not multiple of block length:../openssl-1.1.1k/crypto/evp/evp_enc.c:445:
# The encryption process is to process padding first and encrypt afterwards.
# The decryption process is chunking decryption first and padding is processed at the end.