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

dnf install maven -y &>> $LOGFILE
VALIDATE $? "Intalling maven"

id roboshop &>> $LOGFILE #Need to check if user already created or not
if [ $? -ne 0 ]
then
    useradd roboshop &>> $LOGFILE
    VALIDATE $? "Adding roboshop user for app"
else
    echo -e "User already created so $Y skipping $N"
fi

mkdir -p /app


curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $LOGFILE
VALIDATE $? "Download shipping source code"

cd /app

unzip -o /tmp/shipping.zip &>> $LOGFILE
VALIDATE $? "Unzipping project"

cd /app
mvn clean package &>> $LOGFILE
VALIDATE $? "Creating artifact"

mv target/shipping-1.0.jar shipping.jar

cp /home/centos/shell-scripting/shipping.service /etc/systemd/system/shipping.service &>> $LOGFILE
VALIDATE $? "Adding unit file"

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "daemon reload"

systemctl enable shipping &>> $LOGFILE
VALIDATE $? "enable shipping"

systemctl start shipping &>> $LOGFILE
VALIDATE $? "start shipping"

dnf install mysql -y &>> $LOGFILE
VALIDATE $? "mysql install"

mysql -h mysql.saitejag.site -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>> $LOGFILE
VALIDATE $? "load sample mysql data"

systemctl restart shipping &>> $LOGFILE
VALIDATE $? "restart shipping"