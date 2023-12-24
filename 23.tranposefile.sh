#!/bin/bash

file=transpose.txt

#approach 1, not suitable for large dataset
col1=$(awk -F ' '  '{print $1F}' transpose.txt)
col2=$(awk -F ' '  '{print $2F}' transpose.txt)

echo $col1
echo $col2
echo
echo

for line in $col1
do
    echo -n "$line  " 
done
echo
for line in $col2
do
    echo -n "$line  " 
done

#appraoch2
# cat $file | wc -l # gives no of rows
# cat $file | head -n 1 | awk '{print NF}' # gives no of columns

NoOfCols=$(cat $file | head -n 1 | awk '{print NF}')
echo "NoOfCols: $NoOfCols"
myarr=()
for ((i=1; i<=$NoOfCols; i++))
do
    colValues=$(awk -v col="$i" '{print $col}' $file) #returns string with space separated col values
    # echo $colValues #eg: Name Age Height
    myarr+=("$colValues") # adding string to array
    # echo "${#colValues}" #gives the length of string
done
echo
echo
echo "lenght of array: ${#myarr[@]}"
for val in "${myarr[@]}" 
do
    echo $val
    # echo "lenght of string: ${#val}"
done

echo
echo
#appraoch3

outArr=()
for ((i=0; i<$NoOfCols; i++))
do
    colNumber=$(($i + 1))
    colValues=$(awk -v col="$colNumber" '{print $col}' $file)
    IFs='   ' read -r -a inArr <<< "$colValues"
    echo "inArr: ${inArr[@]}"
done
