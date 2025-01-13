#!/bin/bash

# Function to print section headers
print_header() {
    echo "===== $1 ====="
}

# Print script header
echo "=================================="
echo "Linux Server Performance Statistics"
echo "=================================="
echo "Report generated on: $(date)"
echo "=================================="
echo

# OS Information
print_header "System Information"
echo "OS Version: $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "Last Boot: $(who -b | awk '{print $3,$4}')"
echo

# Load Average
print_header "System Load"
load_avg=$(cat /proc/loadavg)
echo "Load Average (1min, 5min, 15min): $load_avg"
echo

# CPU Usage
print_header "CPU Usage"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "Total CPU Usage: ${cpu_usage}%"
echo "CPU Details:"
lscpu | grep -E "^CPU\(s\):|^Thread|^Core|^Model name" | sed 's/^/  /'
echo

# Memory Usage
print_header "Memory Usage"
free -h | awk '
/Mem:/ {
    printf "Total Memory: %s\n", $2
    printf "Used Memory: %s\n", $3
    printf "Free Memory: %s\n", $4
    printf "Memory Usage: %.2f%%\n", ($3/$2)*100
}'
echo

# Swap Usage
print_header "Swap Usage"
free -h | awk '
/Swap:/ {
    printf "Total Swap: %s\n", $2
    printf "Used Swap: %s\n", $3
    printf "Free Swap: %s\n", $4
    if ($2 != "0B") {
        printf "Swap Usage: %.2f%%\n", ($3/$2)*100
    } else {
        printf "Swap Usage: 0%\n"
    }
}'
echo

# Disk Usage
print_header "Disk Usage"
df -h | awk '
BEGIN {
    printf "%-20s %-10s %-10s %-10s %-6s %s\n", "Filesystem", "Size", "Used", "Avail", "Use%", "Mounted"
}
!/^Filesystem/ && !/^tmpfs/ && !/^devtmpfs/ && !/^udev/ {
    printf "%-20s %-10s %-10s %-10s %-6s %s\n", $1, $2, $3, $4, $5, $6
}'
echo

# Top 5 CPU-consuming processes
print_header "Top 5 Processes by CPU Usage"
ps aux --sort=-%cpu | head -6 | awk '
NR==1 {
    printf "%-12s %-8s %-6s %-6s %-8s %-25s\n", "USER", "PID", "%CPU", "%MEM", "TIME", "COMMAND"
}
NR>1 {
    printf "%-12s %-8s %-6.1f %-6.1f %-8s %-25s\n", $1, $2, $3, $4, $10, $11
}'
echo

# Top 5 memory-consuming processes
print_header "Top 5 Processes by Memory Usage"
ps aux --sort=-%mem | head -6 | awk '
NR==1 {
    printf "%-12s %-8s %-6s %-6s %-8s %-25s\n", "USER", "PID", "%CPU", "%MEM", "TIME", "COMMAND"
}
NR>1 {
    printf "%-12s %-8s %-6.1f %-6.1f %-8s %-25s\n", $1, $2, $3, $4, $10, $11
}'
echo

# Currently logged in users
print_header "Currently Logged In Users"
who | awk '
BEGIN {
    printf "%-12s %-12s %-16s %s\n", "USER", "TTY", "LOGIN TIME", "FROM"
}
{
    printf "%-12s %-12s %-16s %s\n", $1, $2, $3" "$4, ($5 == "(" ? $6 : "local")
}'
echo

# Failed login attempts
print_header "Recent Failed Login Attempts"
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | tail -5 | awk '{
        printf "User: %-15s From: %-15s Time: %s %s %s\n", $9, $11, $1, $2, $3
    }'
else
    echo "Auth log not accessible or not found"
fi
echo

# Network Statistics
print_header "Network Statistics"
echo "Active Internet Connections:"
ss -tuln | grep -v "UNCONN" | grep "LISTEN" | awk '
BEGIN {
    printf "%-15s %-20s\n", "Protocol", "Local Address:Port"
}
NR>1 {
    printf "%-15s %-20s\n", $1, $5
}'
