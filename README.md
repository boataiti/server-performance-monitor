# server-performance-monitor
A bash script to analyze server performance statistics

Linux Server Performance Monitor

A bash script to analyze and display server performance statistics. This tool provides a comprehensive overview of system resources and performance metrics.

Features

CPU usage monitoring
Memory usage statistics (Free vs Used with percentages)
Disk usage analysis (Free vs Used with percentages)
Top 5 processes by CPU usage
Top 5 processes by memory usage

Additional Features

System information (OS version, kernel version)
System uptime and last boot time
Load average metrics
Swap usage statistics
Currently logged-in users
Recent failed login attempts
Network statistics (listening ports)

Prerequisites

Linux-based operating system
Bash shell
Basic system utilities (top, ps, free, df, etc.)

Installation

Clone this repository:

bashCopygit clone https://github.com/boataiti/server-performance-monitor.git

Navigate to the project directory:

bashCopycd server-performance-monitor

Make the script executable:

bashCopychmod +x server-stats.sh
Usage
Run the script with sudo privileges to access all system statistics:
bashCopysudo ./server-stats.sh
Sample Output
Copy==================================
Linux Server Performance Statistics
==================================
Report generated on: Mon Jan 13 10:00:00 EST 2025
==================================

===== System Information =====
OS Version: Ubuntu 22.04.3 LTS
Kernel Version: 5.15.0-88-generic
Uptime: up 15 days, 3 hours, 42 minutes
Last Boot: 2024-12-29 06:18

===== CPU Usage =====
Total CPU Usage: 25.6%
...
Contributing

Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request.

License

This project is licensed under the MIT License - see the LICENSE file for details.
Acknowledgments

Thanks to the Linux community for the various system utilities used in this project
Special thanks to all contributors who help improve this tool

Project URL
Server Performance Monitor.
https://roadmap.sh/projects/server-stats
