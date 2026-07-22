#! /bin/bash

source ./common.sh

cp $SCRIPT_PATH/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
VALIDATE $? "copying the script"

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "rabbitmq install"

systemctl enable rabbitmq-server &>>$LOG_FILE
VALIDATE $? "enable rabbitmq" 

systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Start the rabbitmq"

rabbitmqctl add_user roboshop roboshop123
VALIDATE $? "User adding"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "Permission set"



