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

grep "bash"

var=$!

echo "$var is process instance id of previous"



