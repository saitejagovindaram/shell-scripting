#!/bin/bash

volumesData=$( df -hT | grep -vE 'tmp|File')

while IFS= read line
do
    diskName=$(awk -F ' ' '{print $1F}')
    usage=$(awk -F ' ' '{print $6F}')
    echo $diskName
    echo $usage
done <<< "$volumesData"