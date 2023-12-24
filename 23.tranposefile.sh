#!/bin/bash

file=tranpose.txt

col1=$(awk -F ' '  '{print $1F}' transpose.txt)
col2=$(awk -F ' '  '{print $2F}' transpose.txt)

for line in $col1
do
    echo -n "$line " 
done
