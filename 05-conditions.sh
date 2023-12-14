#!/bin/bash

NUMBER=$1

if [ $NUMBER -eq 100 ] # -ge, -le, -gt, -lt, -ne
    then
        echo "number is equal to 100"
    elif [ $NUMBER -gt 100 ]
    then
        echo "number is greater than 100"
    elif [ $NUMBER -lt 100 ]
    then
        echo "number is less than 100"
fi