#!/bin/bash

DATE=$(date)
echo "script started executing at: $DATE"
echo "################### ARGUMENTS #############################"
echo "argument 0, i.e \$0 is fileName: $0"
echo "argument 1, i.e \$1: $1"
echo "argument 2, i.e \$2: $2"
echo "last argument, i.e \$N: $N" 
echo "list of arguments passed are, \$@: $@"
echo "Number of arguments passed, \$#: $#"
echo "################### ARRAYS #############################"

FRUITS=("banana", "apple", "pineapple", "strawberry")
echo "first fruit: ${FRUITS[0]}"
echo "second fruit: ${FRUITS[1]}"
echo "third fruit: ${FRUITS[2]}"
echo "fourth fruit: ${FRUITS[3]}"
echo "all fruits: ${FRUITS[@]}"

echo "################################################"

STR1="Saiteja"
STR2="Govindaram"
NUMBER1=12
NUMBER2=20
echo "\$STR1+\$STR2: $STR1+$STR2"
echo "\$STR1\$STR2: $STR1$STR2"
echo "\$STR1 \$STR2: $STR1 $STR2"
echo "################################################"
echo "\$STR1+\$NUMBER1: $STR1+$NUMBER1"
echo "\$((\$STR1+\$NUMBER1)): $(($STR1+$NUMBER1))"
echo "################################################"
echo "\$STR1*\$NUMBER1: $STR1*$NUMBER1"
echo "\$((\$NUMBER1*\$NUMBER2)): $(($NUMBER1*$NUMBER2))"
echo "################################################"
echo "\$STR1/\$NUMBER1: $STR1/$NUMBER1"
echo "\$((\$NUMBER2/\$NUMBER2)): $(($NUMBER2/$NUMBER1))"
echo "################################################"
echo "\$STR1%\$NUMBER1: $STR1%$NUMBER1"
echo "\$NUMBER2%\$NUMBER1: $NUMBER2%$NUMBER1"
echo "\$((\$NUMBER2%\$NUMBER2)): $(($NUMBER2%$NUMBER1))"
echo "################################################"
echo "\$STR1-\$NUMBER1: $STR1-$NUMBER1"
echo "\$NUMBER2-\$NUMBER1: $NUMBER2-$NUMBER1"
echo "\$((\$NUMBER2-\$NUMBER2)): $(($NUMBER2-$NUMBER1))"