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
        echo "ERROR:: Please run the script with the root access" &>>$LOG_FILE
        exit 1
fi 

SOURCE_DIR=$1

DEST_DIR=$2

DAYS=${3:-14}

if [ $# -lt 2 ]; then 
    echo -e "ERROR:: Please give the $R source and destinatio dir along with the script $N" &>>$LOG_FILE
fi 

if [ ! -d $SOURCE_DIR ]; then
    echo -e " The direction $SOURCE_DIR $R doesnot exist $N" &>>$LOG_FILE
fi 

if [ ! -d $DEST_DIR ]; then 
    echo -e " The direction $DEST_DIR $R doesnot exist $N" &>>$LOG_FILE
fi 

echo $SOURCE_DIR

echo $DEST_DIR

echo $DAYS


FIND_FILE=$(find $SOURCE_DIR -type f -mtime +$DAYS)

if [ ! -z "${FIND_FILE}" ]; then 
    echo "Files are available" 
    TIME_STAMP=$(date +%F-%H%M)
    ZIP_FILE_NAME="$DEST_DIR/app-log.$TIME_STAMP.zip"
    echo "Zip file name: $ZIP_FILE_NAME" 
    find $SOURCE_DIR -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

    if [ -f $ZIP_FILE_NAME ]; then
        echo -e "Archival is $G Successful $N" | tee -a $LOG_FILE
        while IFS= read -r filename
        do
            echo $filename
            rm -rf $filename
        done <<< $FIND_FILE
    else
        echo -e "Zip $R not successful $N" | tee -a $LOG_FILE
    fi
else
    echo "No files to Archive" 
fi



    