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


var=$(id -u)

echo $var
echo "$? is the status"
echo $USER
echo "$? is the status"
echo $PWD
echo "$? is the status"
echo $HOME
echo "$? is the status"
echo $(df -h)
echo "$? is the status"








