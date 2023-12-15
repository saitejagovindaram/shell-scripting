#!/bin/bash

ID=$(id -u)

validate(){
    if [ $1 -ne 0 ]
    then
        echo "ERROR:: $2"
    else
        echo "SUCCESS:: $2"
    fi
}

if [ $ID -ne 0 ]
then    
    echo "Not Allowed to run, please run as root user"
    exit 1  #exit status 0 is success, we can it exit status through $?
fi

yum install mysql -y
validate $? "Installing MySQL"