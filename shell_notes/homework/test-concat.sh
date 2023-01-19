#!/bin/bash

#
# A test script for the concatenate command.
#
# Created by gback@cs.vt.edu for CS 3214, Summer 2020.
# updated Fall 2021 + Spring 2022
#

# Create 3 small sample files
cat > sample1.in << EOF
This is sample input file 1
EOF

cat > sample2.in << EOF
This is sample input file 2
EOF

cat > "sample 3.in" << EOF
This is sample input file 3
EOF

function check() {
    testname=$1
    expect=$2
    OUTPUT=$3
:<<!
xargs（英文全拼： eXtended ARGuments）是给命令传递参数的一个过滤器，也是组合多个命令的一个工具。
xargs 可以将管道或标准输入（stdin）数据转换成命令行参数，也能够从文件的输出中读取数据。
xargs 也可以将单行或多行文本输入转换为其他格式，例如多行变单行，单行变多行。
xargs 默认的命令是 echo，这意味着通过管道传递给 xargs 的输入将会包含换行和空白，不过通过 xargs 的处理，换行和空白将被空格取代
!
    STDERR=$(cat $4 | xargs echo)
    expectedSTDERR=$5
#    if [[ $OUTPUT = ${expect} ]] # 标准输出流输出正确
#    then
#        if [[ $STDERR = ${expectedSTDERR} ]] #标准错误流输出正确
#        then
#            echo "Passed ${testname}"
#        else
#            echo "Failed ${testname}"
#            echo Received output ${STDERR}
#            echo Expected output ${expectedSTDERR}
#        fi
#    else
#        echo "Failed ${testname}, ${OUTPUT}"
#    fi
    # 这部分是我自己加上去的,为了看自己的标准输出流
    echo "Failed ${testname}"
#    echo Received std output ${OUTPUT}
#    echo Expected std output ${expect}
    echo Received err output ${STDERR}
    echo Expected err output ${expectedSTDERR}
}

#
# Invoke your program in several combinations to test its function.
# These tests try to anticipate various mistakes and shortcuts I've seen
# students take in the past.
# A SHA 256 hash of the expected output is used for each test.
#

function test_program() {
    PRG=$1
#    Linux mktemp命令用于建立暂存文件。
    ETEMP=$(mktemp)
:<<!
    trap [-lp] [[arg] signal_spec ...]
    -l    打印信号名称以及信号名称对应的数字。
    -p    显示与每个信号关联的trap命令。

    用于指定在接收到信号后将要采取的动作。
    脚本程序被中断时执行清理工作。

    执行 EXIT 时, 执行 /bin/rm -f 命令
    -f 即使原档案属性设为唯读，亦直接删除，无需逐一确认。
!
    trap '/bin/rm -f "$ETEMP"' EXIT

:<<!
  运行当前目录下的PRG程序,传递参数为 sample1.in sample2.in 将标准错误流内容写入 ETEMP 文件中
  再将信息进行sha256sum加密,cut指定分隔符为\,展示第一列数据

  标准输入文件(stdin)：stdin的文件描述符为0，Unix程序默认从stdin读取数据。
  标准输出文件(stdout)：stdout 的文件描述符为1，Unix程序默认向stdout输出数据。
  标准错误文件(stderr)：stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。
!
    # 执行传入的脚本将标准错误流内容传入ETEMP文件 将标准输入流内容加密后赋值给OUTPUT1变量
    OUTPUT1=$(./${PRG} sample1.in sample2.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    # 执行check方法 传入5个参数分别是(测试名,期待的标准输出答案,实际标准输出,实际的标准错误流输出,期待的标准错误流输出)
    check "Test 1" c4b579e3ea3922765db153a6ed49058025fc3c0a59ff130fc67cb03d578c8e33 "${OUTPUT1}" \
        ${ETEMP} "$(echo {sample1.in,sample2.in}' is a regular file')"

    OUTPUT2=$(./${PRG} sample2.in sample1.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 2" 47271334789e3ada63fc48325ad428cfd449a7f948a63eb965cdc45d6d4d775a "${OUTPUT2}" \
        ${ETEMP} "$(echo {sample2.in,sample1.in}' is a regular file')"

    OUTPUT3=$(./${PRG} sample1.in sample2.in sample2.in sample1.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 3" d9b86e31f2a51b191bb625c2f0deb35fbe2a921fae27ec4da4989761c72918c2 "${OUTPUT3}" \
        ${ETEMP} "$(echo {sample1.in,sample2.in,sample2.in,sample1.in}' is a regular file')"

    OUTPUT4=$(echo 'ABC' | ./${PRG} 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 4" 8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69 "${OUTPUT4}" \
        ${ETEMP} "$(echo standard input is a pipe)"

    OUTPUT5=$(echo -n 'ABC' | ./${PRG} 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 5" b5d4045c3f466fa91fe2cc6abe79232a1a57cdf104f7a26e716e0a1e2789df78 "${OUTPUT5}" \
        ${ETEMP} "$(echo standard input is a pipe)"

    OUTPUT6=$(echo -n 'ABC' | ./${PRG} - 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 6" b5d4045c3f466fa91fe2cc6abe79232a1a57cdf104f7a26e716e0a1e2789df78 "${OUTPUT6}" \
        ${ETEMP} "$(echo standard input is a pipe)"

    OUTPUT7=$(echo -n 'ABC' | ./${PRG} sample1.in - sample2.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 7" fe86444009a4114a7278f4fbcfff9a7ed17844f6050c2db9e691316b902a6f39 "${OUTPUT7}" \
        ${ETEMP} "$(echo sample1.in is a regular file \
                         standard input is a pipe \
                         sample2.in is a regular file)"
:<<!
dd 可从标准输入或文件中读取数据，根据指定的格式来转换数据，再输出到文件、设备或标准输出。
if=文件名：输入文件名，默认为标准输入。即指定源文件。
of=文件名：输出文件名，默认为标准输出。即指定目的文件。
ibs=bytes：一次读入bytes个字节，即指定一个块大小为bytes个字节。
obs=bytes：一次输出bytes个字节，即指定一个块大小为bytes个字节。
bs=bytes：同时设置读入/输出的块大小为bytes个字节。

count=blocks：仅拷贝blocks个块，块大小等于ibs指定的字节数。
!
    OUTPUT8=$(dd if=/dev/zero of=/dev/stdout bs=1024 count=10000 2>/dev/null | ./${PRG} sample1.in - sample2.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 8" 292ed644f2902d0367fbc0a18a0659b12e6f177dc0a4d176069db012a943d222 "${OUTPUT8}" \
        ${ETEMP} "$(echo sample1.in is a regular file \
                         standard input is a pipe \
                         sample2.in is a regular file)"

    OFILE=/tmp/abc.$(whoami).$$
    trap '/bin/rm -f "$OFILE"' EXIT
    # total size of file is about 150MB, but we limit the programs virtual memory to about 120MB
    # if the program doesn't buffer correctly, this will fail.
    # the large limit is to accommodate memory hogs like the JVM
    dd if=/dev/urandom of=${OFILE} bs=1024 count=150000 2>/dev/null
    if [[ ! "$SKIP_MEMORY_LIMIT" = "yes" ]]; then
        # The JVM, and possibly other language runtimes, don't react
        # well when run under a small virtual memory limit.
        # We will not use ulimit in those cases, instead, 
        # for Java, we will use a wrapper script that limits memory on the
        # JVM side, as in java -Xmx120m ....
        ulimit -d 120000
    fi
    EXPECT=$(sha256sum ${OFILE} | cut -d\  -f1)
    # TODO
    OUTPUT9=$(<${OFILE} ./${PRG} 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 9" ${EXPECT} "${OUTPUT9}" \
        ${ETEMP} "$(echo standard input is a regular file)"

    OUTPUT10=$(./${PRG} ${OFILE} 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 10" ${EXPECT} "${OUTPUT10}" \
        ${ETEMP} "$(echo ${OFILE} is a regular file)"

    OUTPUT11=$(./${PRG} < sample1.in sample2.in sample2.in - sample1.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 11" d8df9ea31448fc1d4304775269a456f0b2aca7e953fa54d4c14acb9c6243a4df "${OUTPUT11}" \
        ${ETEMP} "$(echo sample2.in is a regular file \
                         sample2.in is a regular file \
                         standard input is a regular file \
                         sample1.in is a regular file)"

    OUTPUT12=$(./${PRG} < sample2.in sample2.in sample2.in - sample1.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 12" aae993f4d8517799820c7a2edd80291e24c35d42541296f47dbcb518f5078535 "${OUTPUT12}" \
        ${ETEMP} "$(echo sample2.in is a regular file \
                         sample2.in is a regular file \
                         standard input is a regular file \
                         sample1.in is a regular file)"

    OUTPUT13=$(./${PRG} < sample\ 3.in sample2.in "sample 3.in" - sample1.in 2>${ETEMP} | sha256sum | cut -d\  -f1)
    check "Test 13" 3ef507147ba354707fe3a877920e4efa23a92baa578fa81384f3d47db2171325 "${OUTPUT13}" \
        ${ETEMP} "$(echo sample2.in is a regular file \
                         sample 3.in is a regular file \
                         standard input is a regular file \
                         sample1.in is a regular file)"

    ARGS=$(for i in $(seq 1 100); do echo sample1.in; done)
    OUTPUT14=$(./${PRG} ${ARGS} 2>${ETEMP} | sha256sum | cut -d\  -f1)
    # shellcheck disable=SC2154
    EXPECTED=$(echo "sample1.in is a regular file"$dummy{1..100})
    check "Test 14" 2d6074cd78e89aed039ab6a110c15114e6d8d2fa2404f9808e7a13ca138df864 "${OUTPUT14}" \
        ${ETEMP} "${EXPECTED}"
}

if [[ $1 != "" && $1 != "concatenate.c" ]]
then
    echo "Testing your program, which is $1"
    test_program $1
else
    echo "Testing concatenate.c"

    # Compile your program
    PRG=concatenate
    gcc -O2 -Wall -Werror -o ${PRG} concatenate.c && test_program ${PRG}
fi

# clean up
/bin/rm sample1.in sample2.in "sample 3.in"