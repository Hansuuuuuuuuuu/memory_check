#!/bin/bash

if [ "$#" -ne 6 ]; then
	echo -e "Usage: \n-c <Critical Threshold> \n-w <Warning Threshold> \n-e <Email>"
	exit
fi

while getopts c:w:e: option; do
 	case "${option}" in
	 	c) critical=${OPTARG};;
	 	w) warning=${OPTARG};;
	 	e) email=${OPTARG};;
 	esac
done

if [ "$warning" -gt "$critical" ]; then
	echo -e "Critical threshold must be greater than warning threshold"
	echo -e "Usage: \n-c <Critical Threshold> \n-w <Warning Threshold> \n-e <Email>"
	exit
fi


totalmem=$( free | grep Mem: | awk '{ print $2 }')
usedmem=$( free | grep Mem: | awk '{ print $3 }')
usage=$( awk -v var1="$usedmem" -v var2="$totalmem" 'BEGIN {print var1/var2 * 100}' )

if echo $usage $critical | awk '{exit !( $1 >= $2)}'; then
	top=$( ps ax --sort -rss -o uname,pid,pcpu,pmem,command| head -n10 )
	subject=$(date "+%Y%m%d %H:%M")
	subject+=" memory check - critical"
	echo "$top" | mail -s "$subject" $email
	exit 2
elif echo $usage $warning | awk '{exit !( $1 >= $2)}'; then
	exit 1
else
	exit 0
fi

#YYYYMMDD HH:MM memory check -critical