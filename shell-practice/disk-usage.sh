#! /bin/bash

DISK_STORAGE=$(df -hT | grep -v Filesystem)
#echo $DISK_STORAGE
DISK_TRESHOLD=2

IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

MESSAGE=""

while IFS= read -r diskusage
do
    DISK_PER=$(echo $diskusage | awk '{print $6}' | cut -d "%" -f1)
    MOUNT_PATH=$(echo $diskusage | awk '{print $7}')

    if [ $DISK_PER -gt $DISK_TRESHOLD ]; then
        MESSAGE+="The path is $MOUNT_PATH and space is $DISK_PER \n"
    fi 

done <<< $DISK_STORAGE

echo $IP_ADDRESS

echo -e "Message is $MESSAGE" 



