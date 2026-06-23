#! /bin/bash

# echo "enter the password"

# read -s Password

# echo "Password is $Password"

# var1=$1

# echo "enter the value of var2"
# read var2



# if [ $(($var1 - $var2)) -gt 100 ]; then 
#     echo "value is more then 100"
# elif [ $(($var1 - $var2)) -gt 50 ]; then
#     echo "valus is gt than 50"
# else
#     echo "value is less then 50"
# fi

R="\e[31m"
G="\e[32m"
N="\e[0m"

mkdir -p "/var/log/shell-script"


$logfile="/var/log/shell-script/Shellscript.txt"

var=$(id -u)

echo $var &>> $logfile
echo "$? is the status" &>>$logfile
echo $USER &>> $logfile
echo "$? is the status" &>>$logfile
echo $PWD &>> $logfile
echo "$? is the status" &>>$logfile
echo $HOME &>> $logfile
echo "$? is the status" &>>$logfile
echo $(df -h) &>> $logfile
echo "$? is the status" &>>$logfile

if [ $? -eq 0 ]; then
    echo -e "$R All the details are updated as paer the requirements $N"
    echo -e "$G Values are update in colurs $N"
fi







