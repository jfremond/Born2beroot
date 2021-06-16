#!/bin/sh

# Getting variables
ARCHITECTURE=$(uname -a)
PHYSICAL_CPU=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
VIRTUAL_CPU=$(grep -c "cpu cores" /proc/cpuinfo)
MEM_USED=$(free --mega | grep Mem | awk '{print $3}')
TOTAL_MEM=$(free --mega | grep Mem | awk '{print $2}')
PERCENT_MEM=$(free --mega | grep Mem | awk '{print ($3/$2) * 100}')

# Function that prints what I need to print
function_to_print()
{
	echo "\t#Architecture : $ARCHITECTURE"
	echo "\t#CPU physical : $PHYSICAL_CPU"
	echo "\t#vCPU : $VIRTUAL_CPU"
	echo "\t#Memory Usage : "$MEM_USED/$TOTAL_MEM"MB ($PERCENT_MEM%)"
}

#Calling the function
function_to_print | wall