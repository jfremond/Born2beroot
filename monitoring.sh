#!/bin/sh

# Getting variables
ARCHITECTURE=$(uname -a)
PHYSICAL_CPU=$(grep "physical info" /proc/cpuinfo | sort -u | wc -l)
VIRTUAL_CPU=$(grep -c "processor" /proc/cpuinfo)

# Printing variables
echo "\t#Architecture : $ARCHITECTURE" | wall -n
echo "\t#CPU physical : $PHYSICAL_CPU"
echo "\t#vCPU : $VIRTUAL_CPU"