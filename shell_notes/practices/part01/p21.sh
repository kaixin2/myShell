read -p "输入数" p
for ((i=1;i<=$p;i++))
do
  for ((o=$i;o<$p;o++))
  do
  echo -n " "
  done
   for ((j=$i-1;j>=0;j--))
   do
   echo -n "* "
 done
echo ""
done


for ((i=1;i<=$p-1;i++))
do
  for ((o=$i;o>0;o--))
  do
  echo -n " "
  done
   for ((j=$i;j<=$p-1;j++))
   do
   echo -n "* "
 done
echo ""
done
