#!/bin/bash
# name:
# department:
# email:
#
INPUT_FILE="a"
#Determine if the argument contains parameters such as -l -f
FLAG_L=0
FLAG_F=0
cnt=0
if [ $# -eq 0 ]
then
    echo "Usage: ./primechk.sh -f <numbersfile> [-l]"
   exit 1
fi
while [ $# != 0 ];do
  if [ $1 == "-lf" ]
  then
    let FLAG_F++
    let FLAG_L++
  elif [ $1 == "-l" ]; then
      FLAG_L=1
  elif [ $1 == "-f" ]; then
      let FLAG_F++
  else
    if [ $FLAG_F != 1 ]
    then
      let FLAG_F=2
    fi
    INPUT_FILE=${1}
    let cnt++
  fi
  shift
done
# Check if the read file exists
if [  $cnt -eq 1  ]
then
  if [ ! -f ${INPUT_FILE}  ]; then
     echo "Error: please check if the file $INPUT_FILE exists"
      exit 2
  fi
fi

if [[ $FLAG_F -ne 1 || $cnt -ne 1 ]]
  then
    echo "Usage: ./primechk.sh -f <numbersfile> [-l]"
    exit 1
fi


# judge one number is a prime or not
isPrime(){

  expr $1 + 10 &> /dev/null
  if [ ! $? -eq 0 ]
  then
    echo 0
  else
     flag=1
    for((i=2; i*i <= $1; ++i))
    do
      if(($1 % i == 0))
      then
          flag=0
          break;
      fi
    done
    echo ${flag}
  fi


}
# arr store all found prime numbers, num is the corresponding subscript,
# maxPrime records the maximum prime number in the search process
num=0
arr=()
maxPrime=0
# Use regular expressions to filter out legal numbers that match the conditions
for e in $(cat ${INPUT_FILE} | grep '[1-9][0-9]*')
do
  e=${e//$'\r'}
  res=$(isPrime $e)
  if(( res == 1 ))
  then
    arr[${num}]=${e}
    let num++
    if((${e} > ${maxPrime}))
    then
      maxPrime=${e}
    fi
  fi
done
# If there are no prime numbers
if((maxPrime == 0))
then
  echo "No prime numbers were found in the file "$INPUT_FILE
  exit 3
fi
# Print different results depending on the parameters entered
if((FLAG_L == 1))
then
  echo ${maxPrime}
  exit 0
else
  for e in ${arr[*]}
  do
    echo ${e}
  done
fi
