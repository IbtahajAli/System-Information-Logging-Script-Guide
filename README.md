# System-Information-Logging-Script-Guide

## Introduction

This guide provides a step-by-step process to create and execute a
script that logs system information. The script will collect data such
as CPU usage, hard disk usage, and RAM usage, and log this information
to a file.

## Step-by-Step Instructions

### Step 1: Setup

1.  *Navigate to Home Directory*

    - Open the terminal and run:

    -     cd

3.  *Create a Directory*

    - Create a new directory named log:

    -     mkdir log

4.  *Navigate to the Created Directory*

    - Move into the newly created directory:

    -     cd log

### Step 2: Create the Script

1.  *Create a Script File*

    - Create a new file named logs.sh:

    -     touch logs.sh

3.  *Edit the Script Using vi or vim*

    - Open the logs.sh file in the vi editor:

    -     vi logs.sh

4.  *Add the Following Content to logs.sh*

    - Copy and paste the following script into the logs.sh file: sh
    
          #!/bin/bash

          LOG_FILE="/var/log/system_info.log"

          # Gathering basic system information
            Name=$(whoami)

          # CPU Usage 
            CPU=$(nproc) 
            CPU_USED=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')  

          # RAM Usage 
            RAM=$(grep -i 'memtotal' /proc/meminfo | awk '{print $2 / (1024^2)}') 
            RAM_USED=$(free -m | awk 'NR==2{printf "%.2f", $3/1024 }')  

          # HDD Usage 
            HDD=$(lsblk -b -d -o NAME,SIZE | grep -E 'sda|sdb' | awk '{sum += $2} END {print sum / (1024^3)}') 
            HDD_USED=$(df -B1 --total | grep 'total' | awk '{print $3 / (1024^3)}')  

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


### 

### Step 3: Make the Script Executable

1.  *Change the Script Permissions*

    - Make the script executable:
      
    -     sh chmod +x logs.sh

### Step 4: Run the Script

1.  *Attempt to Run the Script*

    - Run the script:

    -     ./logs.sh

    - If you see the error Permission denied for
      /var/log/system_info.log, follow the next steps.

### Step 5: Addressing Permission Issues

1.  *Attempt to Navigate to the Log Directory and Create the Log File*

    - Navigate to the log directory:

    -     cd /var/log

    - Attempt to create the log file:

    -     touch system_info.log

    - If you get a Permission denied error, proceed with the following
      step.

3.  *Use sudo to Create the Log File*

    - Create the log file with sudo:

    -     sudo touch /var/log/system_info.log

### Step 6: Run the Script as Root

1.  *Run the Script with sudo*

    - Run the script as root:

     -     sudo ./logs.sh

3.  *Check the Log File for Entries*

    - View the contents of the log file:
   
    -     cat /var/log/system_info.log

### Step 7: Automate the Script Using Cron

1.  *Edit the Crontab to Run the Script Periodically*

    - Open the crontab editor:
      
    -     sudo crontab -e

2.  *Add the Following Line to Run the Script Every 2 Minutes*

        - Add this line to the crontab: sh \*/2 \* \* \* \* /home/log/logs.sh'
      
    **add your directory file instaed of this /home/log/logs.sh**
    
4.  *Save and Exit the Crontab Editor*

### Step 8: Verify Cron Job

1.  *List the Crontab Entries to Verify*

    - Check the crontab entries:
      
    -     sudo crontab -l

## Example Outputs

- *Running the scripts:*
  
-     sudo ./logs.sh

  - Output: Name: root CPU: 12 CPUs CPU Used: 2.1 % HDD: 512 GB HDD 
    Used: 103.448 GB RAM: 23.3775 GB RAM Used: 3.28 GB 

- *Checking the log file:*
-     cat /var/log/system_info.log 

  - Output: 2024-07-20 20:56:25 - Name: root, CPU: 12 CPUs, CPU Used: 
    6.1 %, HDD: 512 GB, HDD Used: 103.452 GB, RAM: 23.3775 GB, RAM Used:
    3.38 GB 
