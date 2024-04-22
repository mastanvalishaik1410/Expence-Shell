#!/bin/bash


USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0|cut -d "." -f1)
LOGFILE=/tmp/$TIMESTAMP-$SCRIPT_NAME.log


VALIDATE(){

if [ $1 -ne 0 ]
then
	echo"$2 is fail"
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

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing Mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling Mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting Mysql server"

mysql -h db.shaik.fun -uroot -pExpenseApp@1 -e 'SHOW DATABASES;' &>>$LOGFILE

if [ $? -ne 0 ]
then
	mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
	VALIDATE $? "Setting root password Mysql server"
else
	echo -e "root password Mysql server already setup....$Y Skipping $N"
fi

