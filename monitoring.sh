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
TOTAL_DISK=$(df -h | awk '{print $2}' | grep [0-9] | paste -sd+ | bc)
DISK_USED=$(df -H | awk '{print $3}' | grep [0-9] | paste -sd+ | bc)
PERCENT_DISK=$(df -H | grep [0-9] | awk '{print ($3/$2)}' | paste -sd+ | bc)
CPU_LOAD=$(head -1 /proc/stat | awk '{print ($2 + $4) / ($2 + $4 + $5) * 100}')
BOOT_DAY=$(who -b | awk '{print $3}')
BOOT_HOUR=$(who -b | awk '{print $4}')
IP_ADDR=$(hostname -I)
MAC_ADDR=$(cat /sys/class/net/enp0s3/address)
TCP_CONN=$(netstat -a | grep "ESTABLISHED" | wc -l)
SUDO_COUNT=$(grep "COMMAND" /var/log/sudo/testlog | wc -l)

# Function that prints what I need to print
function_to_print()
{
	echo "\t#Architecture : $ARCHITECTURE"
	echo "\t#CPU physical : $PHYSICAL_CPU"
	echo "\t#vCPU : $VIRTUAL_CPU"
	echo "\t#Memory Usage : "$MEM_USED/$TOTAL_MEM"MB ($PERCENT_MEM%)"
	echo "\t#Disk usage : "$DISK_USED/$TOTAL_DISK" ($PERCENT_DISK%)"
	echo "\t#CPU load : $CPU_LOAD%"
	echo "\t#Last boot : $BOOT_DAY $BOOT_HOUR"
	echo "\t#Network : IP $IP_ADDR($MAC_ADDR)"
	echo "\t#Connexions TCP : $TCP_CONN ESTABLISHED"
	echo "\t#Sudo : $SUDO_COUNT cmd"
}

#Calling the function
function_to_print | wall