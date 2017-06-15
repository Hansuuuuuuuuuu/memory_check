#!/bin/bash


totalmem=$( free | grep Mem: | awk '{ print $2 }')
freemem=$( free | grep Mem: | awk '{ print $4 }')



echo $totalmem
echo
echo $freemem