#! /bin/bash

source ./common.sh

user_check

dnf install mysql-server -y &>>LOG_FILE
VALIDATE $? "Install Mysql server"

systemctl enable mysqld &>>LOG_FILE
VALIDATE $? "Enable MySQL Server"

systemctl start mysqld &>>LOG_FILE
VALIDATE $? "Start Mysql Server"

mysql_secure_installation --set-root-pass RoboShop@1 &>>LOG_FILE
VALIDATE $? "Rootpassword is update" 