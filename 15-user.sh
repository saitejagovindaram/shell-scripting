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

curl -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE
VALIDATE $? "downloading user appliation"

cd /app
unzip -o /tmp/user.zip &>> $LOGFILE #need to override the files if already exist
VALIDATE $? "unzipping user"


npm install &>> $LOGFILE
VALIDATE $? "Installing dependencies"

cp /home/centos/shell-scripting/user.service /etc/systemd/system/user.service
VALIDATE $? "copying user service unit file"

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "Reload deemon"

systemctl enable user &>> $LOGFILE
VALIDATE $? "enabling user"

systemctl start user &>> $LOGFILE
VALIDATE $? "starting user"


cp /home/centos/shell-scripting/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
VALIDATE $? "Setting up mongo repo"

dnf install mongodb-org-shell -y &>> $LOGFILE
VALIDATE $? "Installing mongo client"

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js &>> $LOGFILE
VALIDATE $? "Saving user sample data to mongodb"

