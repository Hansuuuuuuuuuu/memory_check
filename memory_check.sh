#!/bin/bash


totalmem=$( free | grep Mem: | awk '{ print $2 }')
freemem=$( free | grep Mem: | awk '{ print $4 }')


usage=$( awk -v var1="$freemem" -v var2="$totalmem" 'BEGIN {print var1/var2}' )




echo $usage