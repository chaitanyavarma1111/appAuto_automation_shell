#! /bin/bash

read -s Password

echo "Password is $Password"

var1=$1

echo "enter the value of var2"
read var2



if [ $(($var1 - $var2)) -gt 100 ]; then 
    echo "value is more then 100"
elif [ $(($var1 - $var2)) -gt 50 ]; then
    echo "valus is gt than 50"
else
    echo "value is less then 50"
fi




