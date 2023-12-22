#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $ID -ne 0 ]
then 
    echo -e "$R You are not a root user $N"
    exit 2
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 .... $R FAILED $N"
        exit 2
    else
        echo -e "$2 .... $G SUCCESS $N"
    fi
}

cp mongo.repo /etc/yum.repos.d/monog.repo
VALIDATE $? "Copied mongoDb repo"


