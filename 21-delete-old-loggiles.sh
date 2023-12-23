#!/bin/bash

sourceDir=/tmp/shell-logs/

filesToDelete=$(find $sourceDir/. -type f -name "*.log")

for file in $filesToDelete
do  
    echo "Deleting file: $file"
done