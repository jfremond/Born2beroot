#!/bin/bash

# Set character encoding
export LANG=C.UTF-8

# Setting variables
ARCH=$(uname -a)
P_CPU=$(grep -c "physical id" /proc/cpuinfo)
V_CPU=$(grep -c "cpu cores" /proc/cpuinfo)
MEM_USED=$(free --mega | grep "Mem" | awk '{print $3}')
MEM_TOTAL=$(free --mega | grep "Mem" | awk '{print $2}')
MEM_PERCENT=$(free --mega | grep "Mem" | awk '{print ($3/$2) * 100}')
DISK_USED=$(df -H | awk '{print $3}' | grep [0-9] | paste -sd+ | bc)
DISK_TOTAL=$(df -H | awk '{print $2}' | grep [0-9] | paste -sd+ | bc)
DISK_PERCENT=$(df -H | awk '{print ($3/$2)}' | grep [0-9] | paste -sd+ | bc)
CPU_LOAD=$(head -1 /proc/stat | awk '{print ($2 + $4) / ($2 + $4 + $5) * 100}')
BOOT_DAY=$(who -b | awk '{print $3}')
BOOT_HOUR=$(who -b | awk '{print $4}')
TCP_CONN=$(netstat -a | grep -c "ESTABLISHED")
USERS_COUNT=$(users | wc -w)
IP_ADDR=$(hostname -I)
MAC_ADDR=$(ip address | grep "ether" | awk '{print $2}')
SUDO_COUNT=$(grep -c "COMMAND" /var/log/sudo/log_file)
if [ "$(lsblk | grep -c "lvm")" -gt 0 ]
then
	LVM_USE="yes"
else
	LVM_USE="no"
fi

# Function to print
print_variables()
{
	echo "\t#Architecture : $ARCH"
	echo "\t#pCPU : $P_CPU"
	echo "\t#vCPU : $V_CPU"
	echo "\t#Memory Usage : "$MEM_USED/$MEM_TOTAL"MB ($MEM_PERCENT%)"
	echo "\t#Disk Usage : "$DISK_USED/$DISK_TOTAL"MB ($DISK_PERCENT%)"
	echo "\t#CPU load : $CPU_LOAD%"
	echo "\t#Last boot : $BOOT_DAY $BOOT_HOUR"
	echo "\t#LVM Use : $LVM_USE"
	echo "\t#TCP connections : $TCP_CONN"
	echo "\t#User log : $USERS_COUNT"
	echo "\t#Network : IP $IP_ADDR($MAC_ADDR)"
	echo "\t#Sudo : $SUDO_COUNT cmd"
}

# Calling the function
print_variables | wall