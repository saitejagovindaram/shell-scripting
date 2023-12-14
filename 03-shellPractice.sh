#!/bin/bash

DATE=$(date)
echo "script started executing at: $DATE"
echo "################################################"
echo "argument 0, i.e \$0 is fileName: $0"
echo "argument 1, i.e \$1: $1"
echo "argument 2, i.e \$2: $2"
echo "list of arguments passed are, \$@: $@"
echo "Number of arguments passed, \$#: $#"
echo "################################################"

FRUITS=("banana", "apple", "pineapple", "strawberry")
echo "first fruit: ${FRUITS[0]}"
echo "second fruit: ${FRUITS[1]}"
echo "third fruit: ${FRUITS[2]}"
echo "fourth fruit: ${FRUITS[3]}"
echo "all fruits: ${FRUITS[@]}"
