#!/bin/bash

sourceDir1=/tmp/shell-logs/
sourceDir2=/tmp/shell-files

# filesToDelete1=$(find $sourceDir1 -type f -name "*.log")
# filesToDelete2=$(find $sourceDir2 -type f -name "*.sh")

filesToDelete1=$(find $sourceDir1 -type f -mtime +14 -name "*.log")
filesToDelete2=$(find $sourceDir2 -type f -mtime +14 -name "*.sh")

# -mtime +5: Matches files whose content was last modified more than 5 days ago.
# -mtime -5: Matches files whose content was last modified less than 5 days ago.
# -mtime 5: Matches files whose content was last modified exactly 5 days ago.

find "/tmp/shell-files" -type f -mtime +14 -name "*.sh" -exec rm {} \;

# find /tmp/shell-files: Searches in the specified directory ($sourceDir2).
# -type f: Looks for files (not directories or other types of files). d for directories
# -mtime +14: Filters files modified more than 14 days ago.
# -name "*.sh": Matches files with names ending in .sh.
# -exec rm {} \;: Executes the rm command on each file found by find. {} represents the found file, and \; indicates the end of the -exec command.

find /source_dir -type f -name "*.txt" -exec cp {} /destination_dir \;
find /directory -type f -name "*.sh" -exec chmod 755 {} \;
find /directory -type f -mtime +30 -exec tar -czvf old_files.tar.gz {} +
# \; terminates the -exec command for each file found by find, executing the command once for each file individually.
# + also terminates the -exec command but groups the found files together, passing multiple filenames to a single invocation of the command.
find /data -type f -name "*.csv" -exec echo {} \; | wc -l
find /directory -type f -name "*oldstring*" -exec rename 's/oldstring/newstring/' {} \;



#using for loop
for file in $filesToDelete1
do  
    echo "Deleting file: $file"
done


#using while loop
while read -r file
do 
    echo "Deleting file: $file"
done <<< "$filesToDelete2"

# Use < when you want a command to take input from a file.
# Use <<< when you want to pass a string directly as input to a command in the script without using an external file.

while read -r file
do 
    echo "Deleting file: $file"
done < /tmp/temp_files.txt


while IFS= read -r file #IFS=Internal field separator
do 
    echo "Deleting file: $file"
done <<< $filesToDelete2

# In this context, IFS= is used to ensure that leading and trailing whitespace characters are preserved. When IFS is set to an empty value (IFS=), it essentially disables word splitting based on spaces or tabs, and only the newline character is treated as a separator.


