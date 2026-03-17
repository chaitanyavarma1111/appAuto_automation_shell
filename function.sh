#! /bin/bash

R="\e[31m"
Y="\e[32m"
G="\e[33m"
N="\e[0m"

echo "enter the speed and road type"

var1=$1 
var2=$2

if [ $var2 = "H" ] && [ $var1 -lt 100 ]; then 
    echo "you are $G good $N"
elif [ $var2 = "H"] && [ $var1 -gt 100 ]; then
    echo "you are $R not at good speed $N keep it less then 100 for $Y orange for sometime $N"
elif [ $var2 = "G"] && [ $var1 -gt 100 ]; then
    echo "kindly stop your vehicle for while and give $Y cool start $N"
else
    echo "Thanks for following rule $Y enjoy your trip $N"
fi


    