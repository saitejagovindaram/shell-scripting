#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%f-%T)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 .... $R FAILED $N"
        exit 2
    else
        echo -e "$2 .... $G SUCCESS $N"
    fi
}

checkroot(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$R You are not a root user $N"
        exit 2
    fi
}

checkroot $(id -u)

dnf module disable mysql -y &>> $LOGFILE
VALIDATE $? "Disable current mysql version"

cp mysql.repo /etc/yum.repos.d/mysql.repo &>> $LOGFILE
VALIDATE $? "Mysql repo adding"

dnf install mysql-community-server -y &>> $LOGFILE
VALIDATE $? "Insatlling mysql"

systemctl enable mysqld
VALIDATE $? "Enable mysql"

systemctl start mysqld
VALIDATE $? "Start mysql"

mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "Setting root user password"