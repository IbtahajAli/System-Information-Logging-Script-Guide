#!/bin/bash

LOG_FILE="/var/log/system_info.log"

# Gathering basic system information
Name=$(whoami)

# CPU Usage
CPU=$(nproc)
CPU_USED=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}') # Add user and system CPU usage

# RAM Usage
RAM=$(grep -i 'memtotal' /proc/meminfo | awk '{print $2 / (1024^2)}')
RAM_USED=$(free -m | awk 'NR==2{printf "%.2f", $3/1024 }') # Used memory in GB

# HDD Usage
HDD=$(lsblk -b -d -o NAME,SIZE | grep -E 'sda|sdb' | awk '{sum += $2} END {print sum / (1024^3)}')
HDD_USED=$(df -B1 --total | grep 'total' | awk '{print $3 / (1024^3)}') # Used disk space in GB

# Timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Displaying the results
echo "Name: $Name"
echo "CPU: $CPU CPUs"
echo "CPU Used: $CPU_USED %"
echo "HDD: $HDD GB"
echo "HDD Used: $HDD_USED GB"
echo "RAM: $RAM GB"
echo "RAM Used: $RAM_USED GB"

# Logging the results with timestamp
echo "$TIMESTAMP - Name: $Name, CPU: $CPU CPUs, CPU Used: $CPU_USED %, HDD: $HDD GB, HDD Used: $HDD_USED GB, RAM: $RAM GB, RAM Used: $RAM_USED GB" >> $LOG_FILE

