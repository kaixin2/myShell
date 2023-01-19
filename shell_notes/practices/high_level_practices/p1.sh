#!/bin/bash

:<<!
 此脚本用于快速完成Goshawk包解析
 param： 输入指定源码文件的解压包文件名
!

# read data from console
param=$1
# shellcheck disable=SC2164
cd cd /12T/nlp-bin/mytemp/"${param}"
./configure

if test -e ./configrue
then
  CoderChecker log -b "make CC=clang HOSTCC=clang" -o compilation.json

  # shellcheck disable=SC2164
  cd /12T/nlp-bin
  ./run /12T/nlp-bin/mytemp/sqlite 10 1
  mkdir /tmp/CSA
  cp ./output/alloc/Alloc* /tmp/CSA/
  cp ./output/free/Free* /tmp/CSA

  mkdir /12T/nlp-bin/CSA_temp
  cd /12T/nlp-bin/mytemp/"${param}"
  echo -Xclang -load -Xclang /12T/nlp-bin/plugins/MemMisuseAnalyzerProPlugin.so -Xclang -analyzer-checker=alpha.unix.MemMisuseChecker -Xclang -analyzer-max-loop -Xclang 1 -Xclang -analyzer-inline-max-stack-depth -Xclang 5 >static_analyzer.cfg
  CodeChecker analyze --analyzers clangsa -j4 compilation.json --saargs static_analyzer.cfg -d apiModeling -d cplusplus -d nullability -d optin -d security -d unix -d valist -d deadcode -d core -d security.insecureAPI.rand --ctu --output /12T/nlp-bin/CSA_temp
  CodeChecker parse /12T/nlp-bin/CSA_temp -e html -o ./reports_html
  tar cf "${param}"_reports.tar ./reports_html
else
  if test -e ./configure.ac
  then
    aclocal
    autoconf
    libtoolize
    autoheader
    automake --add-missing
   else
     make
   fi
fi