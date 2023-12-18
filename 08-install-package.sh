#!/bin/bash

ID=$(id -u)

if [ $ID -ne 0 ]
then
    echo "You dont have permission, Please run using Root access"
    exit 1
fi

validate(){
    if [ $1 -ne 0 ]
    then
        echo "$2 ... FAILED"
    else
        echo "$1 ... SUCCESS"
    fi
}

for package in $@
do
    yum list installed $package
    if [ $? -ne 0 ]
    then
        yum install $package -y

    else
        echo "$package is already installed ... Skipped"
    fi
done
