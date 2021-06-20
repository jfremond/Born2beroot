#!/bin/sh

#Set character encoding
export LANG=C.UTF-8

# Getting variables
ARCHITECTURE=$(uname -a)
PHYSICAL_CPU=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
VIRTUAL_CPU=$(grep -c "cpu cores" /proc/cpuinfo)
MEM_USED=$(free --mega | grep Mem | awk '{print $3}')
TOTAL_MEM=$(free --mega | grep Mem | awk '{print $2}')
PERCENT_MEM=$(free --mega | grep Mem | awk '{print ($3/$2) * 100}')
TOTAL_DISK=$(df | awk '{print $2}' | grep [0-9] | paste -sd+ - | bc)
DISK_USED=$(df | awk '{print $3}' | grep [0-9] | paste -sd+ - | bc)
PERCENT_DISK=$(df | awk '{print ($3/$2) * 100}' | grep [0-9] | paste -sd+ - | bc)
BOOT=$(who -b)
USER_LIST=$(cut -d: -f1 /etc/passwd)

# Function that prints what I need to print
function_to_print()
{
	echo "\t#Architecture : $ARCHITECTURE"
	echo "\t#CPU physical : $PHYSICAL_CPU"
	echo "\t#vCPU : $VIRTUAL_CPU"
	echo "\t#Memory Usage : "$MEM_USED/$TOTAL_MEM"MB ($PERCENT_MEM%)"
	echo "\t#Disk usage : "$DISK_USED/$TOTAL_DISK" ($PERCENT_DISK%)"
	echo "\t#Last boot : $BOOT"
	echo "\t#Number users : $(USER_LIST)" #WRONG
}

#Calling the function
function_to_print | wall