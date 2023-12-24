#!/bin/bash

volumesData=$( df -hT | grep -vE 'tmp|File')

while IFS= read line
do
    diskName=$(awk -F '{print $1F}' $line)
    usage=$(awk -F '{print $6F}' $line)
    echo $diskName
    echo $usage
done <<< "$volumesData"