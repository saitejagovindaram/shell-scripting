#!/bin/bash

volumesData=$( df -hT | grep -vE 'tmp|File')

while IFS= read line
do
    echo $line
done <<< "$volumesData"