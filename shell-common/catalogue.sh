#! /bin/bash

source ./common.sh
appname=catalogue

user_check
app_setup
nodejs_setup
systemd_setup

cp $SCRIPT_PATH/mongo.repo /etc/yum.repos.d/mongo.repo 
VALIDATE $? "Copy the repo file"

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "Installing the mongod"

INDEX=$(mongosh mongodb.chaitanya.cloud --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")

if [ $INDEX -le 0 ]; then 
    mongosh --host mongodb.chaitanya.cloud </app/db/master-data.js
else
    echo -e "$G Database already exist $N" | tee -a $LOG_FILE 
fi

