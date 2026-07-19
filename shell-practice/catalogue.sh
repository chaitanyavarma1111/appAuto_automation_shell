#! /bin/bash

set -e

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SCRIPT_PATH=$PWD
DB_CONNECTION="mongodb.chaitanya.cloud"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "Script Started execution at $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then 
    echo "ERROR:: Please run the script with the root access"
    exit 1
fi 

trap 'echo "There is error in $LINENO and the command is $BASH_COMMAND" ' ERR &>>$LOG_FILE


dnf module disable nodejs -y &>>$LOG_FILE
dnf module enable nodejs:20 -y &>>$LOG_FILE
dnf install nodejs -y &>>$LOG_FILE

echo -e "Installing Nodejs is $G Successful $N" | tee -a $LOG_FILE

user_robo=$(id roboshop)

if [ $user_robo -ne 0 ]; then 
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop 
    echo -e "User creation $G Successful $N" &>>$LOG_FILE
else
    echo -e "User Already exist so $Y ...SKIPPING... $N" &>>$LOG_FILE
fi

echo -e "User check in $G Successful $N" | tee -a $LOG_FILE

mkdir -p /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>>$LOG_FILE
cd /app
rm -rf *
unzip /tmp/catalogue.zip &>>$LOG_FILE
npm install &>>$LOG_FILE

echo -e "Instannling Catalogue application  $G Successful $N" | tee -a $LOG_FILE

cp $SCRIPT_PATH/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload 
systemctl enable catalogue 
systemctl start catalogue

echo -e "Installing the service is $G completed $N" | tee -a $LOG_FILE

cp -p $SCRIPT_PATH/mongo.repo /etc/yum.repos.d/mongo.repo


dnf install mongodb-mongosh -y &>>$LOG_FILE

INDEX=$(mongosh mongodb.chaitanya.cloud --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")

if [ $INDEX -le 0 ]; then 
    mongosh --host mongodb.chaitanya.cloud </app/db/master-data.js
else
    echo -e "$G Database already exist $N" | tee -a $LOG_FILE 
fi 








