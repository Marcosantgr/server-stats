#!/bin/bash

echo "================ SERVER PERFORMANCE STATS ================"
echo

### 🧠 CPU USAGE ###
echo "---- CPU Usage ----"
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print $4}' | awk '{print $1}' | sed 's/id//')
CPU_USED=$(awk "BEGIN {print 100 - $CPU_IDLE}")
printf "Total CPU Used: %.2f%%\n" "$CPU_USED"
echo

### 🧮 MEMORY USAGE ###
echo "---- Memory Usage ----"
read TOTAL USED FREE <<< $(free -m | awk '/Mem:/ {print $2, $3, $4}')
MEM_PERCENT=$(awk "BEGIN {print ($USED/$TOTAL)*100}")
echo "Total: ${TOTAL}MB"
echo "Used : ${USED}MB"
echo "Free : ${FREE}MB"
printf "Usage: %.2f%%\n" "$MEM_PERCENT"
echo

### 💾 DISK USAGE ###
echo "---- Disk Usage (Root /) ----"
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')
echo "Total: $DISK_TOTAL"
echo "Used : $DISK_USED"
echo "Free : $DISK_FREE"
echo "Usage: $DISK_PERCENT"
echo

### 🔥 TOP 5 CPU PROCESSES ###
echo "---- Top 5 Processes by CPU ----"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo

### 🧩 TOP 5 MEMORY PROCESSES ###
echo "---- Top 5 Processes by Memory ----"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo

echo "=========================================================="

