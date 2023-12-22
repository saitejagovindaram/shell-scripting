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

ID=$(id -u)
checkroot $?

dnf module disable nodejs -y &>> $LOGFILE
VALIDATE $? "Disabling nodejs"

dnf module enable nodejs:18 -y &>> $LOGFILE
VALIDATE $? "Enabling nodejs 18"

dnf install nodejs -y &>> $LOGFILE
VALIDATE $? "Installing nodejs 18"

id roboshop &>> $LOGFILE #Need to check if user already created or not
if [ $? -ne 0 ]
then
    useradd roboshop &>> $LOGFILE
    VALIDATE $? "Adding roboshop user for app"
else
    echo -e "User already created so $Y skipping $N"
fi

mkdir -p /app #Need to check if directory already created or not

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip &>> $LOGFILE
VALIDATE $? "downloading catalogue appliation"

cd /app
unzip -o /tmp/catalogue.zip &>> $LOGFILE #need to override the files if already exist
VALIDATE $? "unzipping catalogue"


npm install &>> $LOGFILE
VALIDATE $? "Installing npm package manager"

cp /home/centos/shell-scripting/catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "copying catalgue service unit file"

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "Reload deemon"

systemctl enable catalogue
VALIDATE $? "enabling catalogue"

systemctl start catalogue
VALIDATE $? "starting catalogue"

cp mongo.repo /etc/yum.repo.d/mongo.repo &>> $LOGFILE
VALIDATE $? "copying mongo repo"

dnf install mongodb-org-shell -y
VALIDATE $? "Installing mongo client"

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js &>> $LOGFILE
VALIDATE $? "Loading data to mongodb"

