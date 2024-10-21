#!/bin/bash

# 
# koteshi's linux maintenance script v0.1
# 


# Update and upgrade the system
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Check if a reboot is needed and schedule it
if [ -f /var/run/reboot-required ]; then
    sudo shutdown -r +5
fi

# Check if Pi-hole is installed and update it
if command -v pihole &> /dev/null; then
    pihole -up
fi

# Self-update script
if [ -f /usr/local/bin/maintenance.sh ]; then
    curl -s https://raw.githubusercontent.com/mkoterski/lnx-toolbox/main/maintenance.sh -o /usr/local/bin/maintenance.sh
    chmod +x /usr/local/bin/maintenance.sh
fi
