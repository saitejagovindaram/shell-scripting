#!/bin/bash

ID=$(id -u)

TIMESTAMP=$(date +%F-%T)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

R="\e[31m"
G=\e[32m
Y=\e[33m
N=\e[0m


validate(){
    if [ $1 -ne 0 ]
    then
        echo "ERROR:: $R $2 $N"
    else
        echo "SUCCESS:: $G $2 $N"
    fi
}

if [ $ID -ne 0 ]
then    
    echo "$R Not Allowed to run, please run as root user $N"
    exit 1  #exit status 0 is success, we can this exit status through $?
fi

yum install mysql -y &>> $LOGFILE
validate $? "Installing MySQL"

yum install httpd -y &>> $LOGFILE
validate $? "Installing httpd"