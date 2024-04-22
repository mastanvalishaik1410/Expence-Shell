#!/bin/bash


USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0|cut -d "." -f1)
LOGFILE=/tmp/$TIMESTAMP-$SCRIPT_NAME.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"


VALIDATE(){

if [ $1 -ne 0 ]
then
	echo "$2 is fail"
	exit 1
else
	echo "$2 is success"
fi
}
if [ $USERID -ne 0 ]
then
	echo "Please run the script with root"
	exit 1
else
	echo "you are super user"
fi

dnf module disable nodejs -y &>>LOGFILE
VALIDATE $? "Disabling NodeJs"

dnf module enable nodejs:20 -y &>>LOGFILE
VALIDATE $? "Enabling NodeJS 20"
dnf install nodejs -y &>>LOGFILE
VALIDATE $? "Installing NodeJs"

useradd expense
VALIDATE $? "User Added"
