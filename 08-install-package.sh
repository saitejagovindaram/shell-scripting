#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $ID -ne 0 ]
then
    echo -e "$R You dont have permission, Please run using Root access $N"
    exit 1
fi

validate(){
    if [ $1 -ne 0 ]
    then
        echo "$2 ... $R FAILED $N"
    else
        echo "$1 ... $G SUCCESS $N"
    fi
}

for package in $@
do
    yum list installed $package
    if [ $? -ne 0 ]
    then
        yum install $package -y

    else
        echo "$package is already installed ... $Y Skipped $N"
    fi
done
