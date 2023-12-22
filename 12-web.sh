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

dnf install nginx -y &>> $LOGFILE
VALIDATE $? "Installing Nginx"


rm -rf /usr/share/nginx/html/* &> $LOGFILE
VALIDATE $? "Removing defalut content"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE
VALIDATE $? "download website"

cd /usr/share/nginx/html

unzip -o /tmp/web.zip &>> $LOGFILE
VALIDATE $? "Extracting app files"

cp /home/centos/shell-scripting/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
VALIDATE $? "configuring reverse proxy"


systemctl enable nginx &>> $LOGFILE
VALIDATE $? "Enabling Nginx"

systemctl start nginx &>> $LOGFILE
VALIDATE $? "staring Nginx"

systemctl restart nginx &>> $LOGFILE
VALIDATE $? "Restart Nginx"

