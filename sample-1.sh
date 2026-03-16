#! /bin/bash


echo "variables to passed"

var1=$1
var2=$2

echo "$@ are input args"

echo "$* are input args"

echo $PWD

echo $USER

echo $HOME

echo "$$ is Process instance id"

var3="string"

var=$(($var1+$var2+$var3))

echo "$var is the value and $var3 is default zero"

var4=("sit","stand",0,1)

echo "${var5[@]}"

echo "${var5[0]} and ${var5[1]} and ${var5[2]} and ${var5[3]}"




