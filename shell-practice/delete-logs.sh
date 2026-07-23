#! /bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"
echo "Script Started execution at $(date)" | tee -a $LOG_FILE


USERID=$(id -u)
if [ $USERID -ne 0 ]; then 
        echo "ERROR:: Please run the script with the root access"
        exit 1
fi 


SOURCE_DIR=/home/ec2-user/practice-logs

if [ ! -d $SOURCE_DIR ]; then
    echo "ERROR:: The directory doesnot exist" 
fi

FIND_FILE=$(find $SOURCE_DIR -iname "*.log" -type f -mtime +10)

while IFS=read -r filename 
do
    echo "file to delete : $filename"
    rm -f $filename

done <<< $FIND_FILE