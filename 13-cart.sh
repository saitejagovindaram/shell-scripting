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

curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $LOGFILE
VALIDATE $? "downloading cart appliation"

cd /app
unzip -o /tmp/cart.zip &>> $LOGFILE #need to override the files if already exist
VALIDATE $? "unzipping cart"


npm install &>> $LOGFILE
VALIDATE $? "Installing dependencies"

cp /home/centos/shell-scripting/cart.service /etc/systemd/system/cart.service
VALIDATE $? "copying cart service unit file"

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "Reload deemon"

systemctl enable cart
VALIDATE $? "enabling cart"

systemctl start cart
VALIDATE $? "starting cart"

