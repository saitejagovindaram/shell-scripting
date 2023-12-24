#!/bin/bash

volumesData=$( df -hT | grep -vE 'tmp|File')

while IFS= read line
do
    diskName=$(awk -F ' ' '{print $1F}')
    echo $diskName
done <<< "$volumesData"