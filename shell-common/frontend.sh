#! /bin/bash

source ./common.sh

user_check

dnf module disable nginx -y &>>$LOG_FILE
VALIDATE $? "disable nginx"
dnf module enable nginx:1.24 -y &>>$LOG_FILE
VALIDATE $? "enable nginx"
dnf install nginx -y
VALIDATE $? "install nginx"


systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "Enable nginx"
systemctl start nginx &>>$LOG_FILE 
VALIDATE $? "Start nginx"


rm -rf /usr/share/nginx/html/*  &>>$LOG_FILE

curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$LOG_FILE

cd /usr/share/nginx/html &>>$LOG_FILE

unzip /tmp/frontend.zip &>>$LOG_FILE

VALIDATE $? "frontend application"

cp $SCRIPT_PATH/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "nginx conf copied"

systemctl restart nginx 
VALIDATE $? "Restart completed "



