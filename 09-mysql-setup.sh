#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%f-%T)
LOGFILE="$0-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 .... $R FAILED $N"
        exit 2
    else
        echo -e "$2 .... $G SUCCESS $N"
    fi
}

if [ $ID -ne 0 ]
then 
    echo -e "$R You are not a root user $N"
    exit 2
fi

cp mongo.repo /etc/yum.repos.d/monog.repo &> $LOGFILE
VALIDATE $? "Copied mongoDb repo"

dnf install mongodb-org -y &> $LOGFILE
VALIDATE $? "Installing MongoDB"

systemctl enable mongod &> $LOGFILE
VALIDATE $? "Enabling mongoDb"

systemctl start mongod &> $LOGFILE
VALIDATE $? "Starting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Exposing mongo to public"

systemctl start mongod &> $LOGFILE
VALIDATE $? "Restarting mongodb"



