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


dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOGFILE
VALIDATE $? "Adding Redis Repo"

dnf module enable redis:remi-6.2 -y &>> $LOGFILE
VALIDATE $? "Enabiling Redis module"

dnf install redis -y &>> $LOGFILE
VALIDATE $? "Installing Redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf &>> $LOGFILE
VALIDATE $? "Exposing Redis to public"

systemctl enable redis &>> $LOGFILE
VALIDATE $? "Enabling Redis Service"

systemctl start redis &>> $LOGFILE
VALIDATE $? "Starting Redis service"