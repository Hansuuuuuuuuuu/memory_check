#!/bin/bash


totalmem=$( free | grep Mem: | awk '{ print $2 }')
usedmem=$( free | grep Mem: | awk '{ print $3 }')


usage=$( awk -v var1="$usedmem" -v var2="$totalmem" 'BEGIN {print var1/var2}' )

while getopts c:w:e: option
do
 case "${option}"
 in
 c) critical=${OPTARG};;
 w) warning=${OPTARG};;
 e) email=${OPTARG};;
 esac
done


echo $usage
echo $critical
echo $warning
echo $email