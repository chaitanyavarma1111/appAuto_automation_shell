#! /bin/bash

source ./common.sh

user_check

cp mongo.repo /etc/yum.repos.d/mongo.repo 
VALIDATE $? "Copy the repo file"

dnf install mongodb-org -y
VALIDATE $? "Installing the mongodb" 

systemctl enable mongod 
VALIDATE $? "Enable Mongodb service"

systemctl start mongod
VALIDATE $? "Starting the Mongod service"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Replacing the config file" 


systemctl restart mongod
VALIDATE $? "Restarting the service"



