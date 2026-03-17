#! /bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "enter the speed and road type"

logfile=$(echo $0 | cut -d "." f1)

scriptname="$logfile.log"

logpath="/var/log/shell-script"

logupdate="$logpath/$scriptname"

mkdir -p "$logpath"


var1=$1 
var2=$2

fun(){

if [ $var2 = "H" ] && [ $var1 -lt 100 ]; then 
    echo -e "you are $G good $N" &>>$logupdate
elif [ $var2 = "H" ] && [ $var1 -gt 100 ]; then
    echo -e "you are $R not at good speed $N keep it less then 100 for $Y orange for sometime $N" &>>$logupdate
elif [ $var2 = "G" ] && [ $var1 -gt 100 ]; then
    echo -e "kindly stop your vehicle for while and give $Y cool start $N" &>>$logupdate
else
    echo -e "Thanks for following rule $Y enjoy your trip $N" |tee -a $logupdate
fi
}

fun $var1 $var2

    