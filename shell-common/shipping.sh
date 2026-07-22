#! /bin/bash

source ./common.sh
appname=shipping

user_check
app_setup
java_setup
systemd_setup

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Mysql installation"

mysql -h $MYSQL_HOST -uroot -pRoboShop@1 -e 'use cities' &>>$LOG_FILE

if [ $? -ne 0 ]; then
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql &>>$LOG_FILE
    VALIDATE $? "schema installation"

    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$LOG_FILE
    VALIDATE $? "app-user installation"

    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$LOG_FILE
    VALIDATE $? "master installation"

else

    echo -e "Shipping data is already loaded ...$Y SKIPPING $N" | tee -a $LOG_FILE

fi

systemctl restart shipping
VALIDATE $? "Restart shipping" 




