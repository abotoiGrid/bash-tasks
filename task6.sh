#Create script, that generates report file with following information:
#current date and time;
#name of current user;
#internal IP address and hostname;
#external IP address;
#name and version of Linux distribution;
#system uptime;
#information about used and free space in / in GB;
#information about total and free RAM;
#number and frequency of CPU cores


#!/bin/bash



echo "Current date and time :  $(date)"  >> report.txt
echo "Name of the current user: $(whoami)" >> report.txt
echo "Hostname : $(hostname), Internal IP : $(hostname -I)" >> report.txt
echo "External IP: $(curl ifconfig.me)" >> report.txt
echo "Linux Distribution : $(grep '^NAME' /etc/os-release | cut -d= -f2), Version : $(grep '^VERSION' /etc/os-release | cut -d= -f2)" >> report.txt
echo "System uptime : $(uptime -p)" >> report.txt
echo "$(df -h / | awk 'NR==2 {print "Used space: " $3 ", Free space: " $4}')" >> report.txt
echo "$(free -h | awk 'NR==2 {print "Total RAM: " $2 ", Free RAM: " $7}')" >> report.txt
echo "Number of CPU Cores : $(nproc)" >> report.txt
echo "CPU Frequencies : " >> report.txt
cat /proc/cpuinfo | grep "MHz" >> report.txt
