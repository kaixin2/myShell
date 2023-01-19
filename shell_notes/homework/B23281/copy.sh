#!/bin/bash
# name:
# department:
# email:
#

judge(){
  arr=$(ls -l $1 | grep $2)
  echo ${#arr}
}
param_num=$#
# if params num is not 2
if [ $# != 2 ]
then
   echo "Usage: namefix.bash <inputfile> <outputfile>"
      exit  1
else
  INPUT_FILE=$1
  OUTPUT_FILE=$2
  # if outFile and inputFile is the same
  if [ ${INPUT_FILE} == ${OUTPUT_FILE} ]; then
     exit 2
  fi
  # check input exists or not
  if [ ! -e ${INPUT_FILE} ]
  then
    echo "input file no exists"
    exit 3
  fi

  # Check if the input file is readable
  if [ ! -r ${INPUT_FILE} ]
  then
    echo "Error: do not have permissions to read the input file" $INPUT_FILE
    exit 3
  fi

  # If the input file is given as a folder, splice in the input file name
  if [ -d ${OUTPUT_FILE} ]
  then
     FILENAME=${INPUT_FILE##*/}
     OUTPUT_FILE=${OUTPUT_FILE}"/"${FILENAME};

        # Determine if the output file is writable
     if [ ! -w ${OUTPUT_FILE} ]
     then
       echo "Error $OUTPUT_FILE is a directory"
       exit 4
     fi
  fi

    # Determine if the output file is writable
 if [ ! -w ${OUTPUT_FILE} ]
 then
   echo "Error: do not have write permission on the output file" $OUTPUT_FILE
   exit 4
 fi

  # print text in outputFile
  cat $INPUT_FILE | while read line
  do
     for j in ${line}
     do
       # All to lowercase
       j=`echo ${j,,}`
       # First character to uppercase
       echo -n ${j^}" " >> ${OUTPUT_FILE}
     done
     echo "" >> ${OUTPUT_FILE}
  done
  cat ${OUTPUT_FILE}
fi