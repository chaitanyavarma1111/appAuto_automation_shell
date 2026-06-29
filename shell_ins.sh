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

logpath="/var/log/shell-script"

logfile="shellscript.txt"

logUpdate=$logpath/$logfile

mkdir -p "$logpath"


var=$(id -u)

echo $var &>>$logUpdate
echo "$? is the status" &>>$logUpdate
echo $USER &>> $logUpdate
echo "$? is the status" &>>$logUpdate
echo $PWD &>> $logUpdate
echo "$? is the status" &>>$logUpdate
echo $HOME &>>$logUpdate
echo "$? is the status" &>>$logUpdate
echo $(df -h) &>>$logUpdate
echo "$? is the status" &>>$logUpdate

if [ $? -eq 0 ]; then
    echo -e "$R All the details are updated as paer the requirements $N"
    echo -e "$G Values are update in colurs $N"
fi


for i in {1..20}
do
    if [ "$i" -eq 10 ]; then
        echo $i   
        echo "The number is 10"
        exit 0
    fi 
done

var1=$1

echo "enter the value of name"
read -s var2

read -s var3


fun $var1 $var2

fun(){
    echo "value of $var3" 
    echo "The value of the user is $var1 and name is $var2"
    
    echo -e "$G Learn how to break the loop $N" &>>$logUpdate
}



