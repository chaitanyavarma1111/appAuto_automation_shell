#! /bin/bash

var1=$1
var2=$2

if($(($var1-$var2)) -gt 100); then 

    echo "value is higher"
else 
    echo "value is lower"

fi 

echo "value of var3 and var4"
read var3
read -s var4

if($(($var3 % var4)) - gt 10); then 

    echo "value is higher"

else if ($(($var3 % $var4)) - gt 20); then

    echo "value is medium"

else

    echo "value is low"

fi 


