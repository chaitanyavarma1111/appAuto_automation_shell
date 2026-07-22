#! /bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


SCRIPT_PATH=$PWD

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "Script Started execution at $(date)" | tee -a $LOG_FILE

VALIDATE(){

    if [ $1 -ne 0 ]; then 
        echo -e "$2 is $R failure $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$2 is $G successful $N" | tee -a $LOG_FILE
    fi
}

USERID=$(id -u)
user_check(){
    if [ $USERID -ne 0 ]; then 
        echo "ERROR:: Please run the script with the root access"
        exit 1
    fi 
}


app_setup(){
    mkdir -p /app
    curl -o /tmp/.zip https://roboshop-artifacts.s3.amazonaws.com/$appname-v3.zip &>>$LOG_FILE
    cd /app
    rm -rf *
    unzip /tmp/$appname.zip &>>$LOG_FILE

    echo "App set-up completed $G Successful $N"
}

systemd_setup(){
    cp $SCRIPT_PATH/$appname.service /etc/systemd/system/$appname.service

    systemctl daemon-reload 
    VALIDATE $? "daemon-reload for $appname"

    systemctl enable $appname 
    VALIDATE $? "enable $appname"

    systemctl start $appname
    VALIDATE $? "$appname started"
}

nodejs_setup(){
    dnf module disable nodejs -y &>>$LOG_FILE
    VALIDATE $? "Disable nodejs"

    dnf module enable nodejs:20 -y &>>$LOG_FILE
    VALIDATE $? "Enable Nodejs"

    dnf install nodejs -y &>>$LOG_FILE
    VALIDATE $? "Nodejs install"

    npm install &>>$LOG_FILE
    VALIDATE $? "npm install"
}
