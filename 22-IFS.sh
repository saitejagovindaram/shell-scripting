#!/bin/bash

find "/tmp/shell-files" -type f -mtime +14 -name "*.sh" -exec rm {} \;

# find "$sourceDir2": Searches in the specified directory ($sourceDir2).
# -type f: Looks for files (not directories or other types of files).
# -mtime +14: Filters files modified more than 14 days ago.
# -name "*.sh": Matches files with names ending in .sh.
# -exec rm {} \;: Executes the rm command on each file found by find. {} represents the found file, and \; indicates the end of the -exec command.

