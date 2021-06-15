#!/bin/sh

# Getting variables
ARCHITECTURE=$(uname -a)
PHYSICAL_CPU=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
VIRTUAL_CPU=$(grep -c "cpu cores" /proc/cpuinfo)

# Function that prints what I need to print
function_to_print()
{
	echo "\t#Architecture : $ARCHITECTURE"
	echo "\t#CPU physical : $PHYSICAL_CPU"
	echo "\t#vCPU : $VIRTUAL_CPU"
}

#Calling the function
function_to_print | wall