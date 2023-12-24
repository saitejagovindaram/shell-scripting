#!/bin/bash

file=transpose.txt

#approach 1, not suitable for large dataset
col1=$(awk -F ' '  '{print $1F}' transpose.txt)
col2=$(awk -F ' '  '{print $2F}' transpose.txt)

echo $col1
echo $col2
echo
echo

# for line in $col1
# do
#     echo -n "$line  " 
# done
# echo
# for line in $col2
# do
#     echo -n "$line  " 
# done

###############
# cat $file | wc -l # gives no of rows
# cat $file | head -n 1 | awk '{print NF}' # gives no of columns

NoOfCols=$(cat transpose.txt | head -n 1 | awk '{print NF}')

for ((i=0; i <$NoOfCols; i++))
do
    colNumber=$(($i + 1))
    colValues=$(awk -v col="$colNumber" '{print $col}' $file)
    echo $colValues
    echo "${#colValues}"
done


