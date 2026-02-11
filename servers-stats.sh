#!/bin/bash

echo "------------------------------------------------"
echo " SERVER STATS - $(date)"
echo "------------------------------------------------"

echo -e "\n🔹 TOTAL CPU USAGE:"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "   Load: $cpu_usage%"

echo -e "\n🔹 TOTAL MEMORY USAGE:"
free -m | awk 'NR==2{printf "   Used: %sMB / Total: %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo -e "\n🔹 TOTAL DISK USAGE:"
df -h / | awk 'NR==2{printf "   Used: %s / Total: %s (%s)\n", $3, $2, $5}'

echo -e "\n🔹 TOP 5 PROCESSES BY CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | awk '{printf "   PID: %-8s | Name: %-15s | CPU: %s%%\n", $1, $2, $3}'
echo -e "\n🔹 TOP 5 PROCESSES BY MEMORY:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | awk '{printf "   PID: %-8s | Name: %-15s | MEM: %s%%\n", $1, $2, $3}'
