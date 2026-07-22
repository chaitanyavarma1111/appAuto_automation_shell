!# /bin/bash

source ./common.sh

user_check

dnf module disable redis -y
VALIDATE $? "Disabline reddis"

dnf module enable redis:7 -y
VALIDATE $? "Enable the required redis"

dnf install redis -y 
VALIDATE $? "Installing Redis" 

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "updating the values"

systemctl enable redis 
VALIDATE $? "Enable redis"

systemctl start redis 
VALIDATE $? "Start the redis" 


