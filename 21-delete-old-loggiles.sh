#!/bin/bash

sourceDir1=/tmp/shell-logs/
sourceDir2=/tmp/shell-files

filesToDelete1=$(find $sourceDir1 -type f -name "*.log")
filesToDelete2=$(find $sourceDir2 -type f -name "*.sh")

#using for loop
for file in $filesToDelete1
do  
    echo "Deleting file: $file"
done

#using while loop
while file
do 
    echo "Deleting file: $file"
done <<< $filesToDelete2