#!/bin/bash

mark=''
for ((ratio=0;${ratio}<=100;ratio+=5))
do
        sleep 0.2
        printf "progress:[%-40s]%d%%\r" "${mark}" "${ratio}"
        mark="##${mark}"
done
echo
