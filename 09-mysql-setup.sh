#!/bin/bash

ID=$(id -u)

if [ $ID -ne 0 ]
then 
    echo "You are not a root user"
    exit 2
fi
