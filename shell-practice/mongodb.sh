#! /bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "Script Started execution at $(date)" | tee -a $LOG_FILE


if [ $USERID -ne 0 ]; then 
    echo "ERROR:: Please run the script with the root access"
    exit 1
fi 

VALIDATE(){

    if [ $1 -ne 0 ]; then 
        echo -e "$2 is $R failure $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is $G successful $N" | tee -a $LOG_FILE
    fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Copy the repo file"

dnf install mongodb-org -y
VALIDATE $? "Installing the mongodb" 

systemctl enable mongod 
VALIDATE $? "Enable Mongodb service"

systemctl start mongod
VALIDATE $? "Starting the Mongod service"

sed 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Replacing the config file" 

systemctl restart mongod
VALIDATE $? "Restarting the service"