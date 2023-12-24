#!/bin/bash

volumesData=$( df -hT | grep -vE 'tmp|File')
message=""
while IFS= read line
do
    diskName=$(echo $line | awk -F ' ' '{print $1F}')
    usage=$(echo $line | awk -F ' ' '{print $6F}' | awk -F % '{print $1F}')
    if [ $usage -gt 1 ]
    then
        message="$message High Disk usage on $diskName: $usage\n"
    fi
    
done <<< "$volumesData"

echo $message