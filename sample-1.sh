#! /bin/bash


#echo "variables to passed"

#var1=$1
#var2=$2

#echo "$@ are input args"

#echo "$* are input args"

#echo $PWD

#echo $USER

#echo $HOME

#echo "$$ is Process instance id"

#var3="string"

#var=$(($var1+$var2+$var3))

#echo "$var is the value and $var3 is default zero"

var=("sit","stand","one","two")

#echo "${var5[@]}"

echo "${var[@]}"

echo "${var[1]}"

var1=(ilo,ve,you)

#echo "${var1[@]}"

#echo "${var1[1]}"

echo "${var1[@]}"   # prints: ilo ve you
echo "${var1[0]}"   # prints: ve



