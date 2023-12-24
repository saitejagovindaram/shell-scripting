#!/bin/bash

file=transpose.txt

#approach 1, not suitable for large dataset
col1=$(awk -F ' '  '{print $1F}' transpose.txt)
col2=$(awk -F ' '  '{print $2F}' transpose.txt)

#this will give us out output
echo $col1
echo $col2

#appraoch2
# cat $file | wc -l # gives no of rows
# cat $file | head -n 1 | awk '{print NF}' # gives no of columns
echo
echo
NoOfCols=$(cat $file | head -n 1 | awk '{print NF}')
echo "NoOfCols: $NoOfCols"
myarr=()
for ((i=1; i<=$NoOfCols; i++))
do
    echo $i
    colValues=$(awk -v col="$i" '{print $col}' $file) #returns string with space separated col values
    echo $colValues #eg: Name Age Height
    # echo "$colValues" #eg: Name
    #                        Age
    #                        Height
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
for ((i=1; i<=$NoOfCols; i++))
do
    echo $i
    colValues=$(awk -v col="$i" '{print $col}' $file) #returns string with space separated col values
    echo $colValues
    IFS=' ' read -r -a inArr <<< $colValues
    echo "inArr: ${inArr[@]}"
    outArr+=("$inArr")
done

echo
echo "outArr: ${outArr[@]}"
