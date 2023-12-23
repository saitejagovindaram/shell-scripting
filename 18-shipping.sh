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

dnf install maven -y
VALIDATE $? "Intalling maven"

useradd roboshop
VALIDATE $? "adding app user"

mkdir -p /app


curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip
VALIDATE $? "Download shipping source code"

cd /app

unzip -o /tmp/shipping.zip
VALIDATE $? "Unzipping project"

cd /app
mvn clean package
VALIDATE $? "Creating artifact"

mv target/shipping-1.0.jar shipping.jar

cp /home/centos/shell-scripting/shipping.service /etc/systemd/system/shipping.serice
VALIDATE $? "Adding unit file"

systemctl daemon-reload
VALIDATE $? "daemon reload"

systemctl enable shipping 
VALIDATE $? "enable shipping"

systemctl start shipping
VALIDATE $? "start shipping"

dnf install mysql -y
VALIDATE $? "mysql install"

mysql -h mysql.saitejag.site -uroot -pRoboShop@1 < /app/schema/shipping.sql 
VALIDATE $? "load sample mysql data"

systemctl restart shipping
VALIDATE $? "restart shipping"