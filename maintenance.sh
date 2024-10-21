#!/bin/bash

# 
# koteshi's linux maintenance script v0.2
# 


# Function to install packages if not already installed
install_if_not_exists() {
    if ! dpkg -l | grep -q $1; then
        sudo apt install -y $1
    fi
}

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Install necessary packages
install_if_not_exists git
install_if_not_exists zsh
install_if_not_exists neofetch

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

# Prompt user to run script once or set up cron job
echo "Would you like to run this script once or set it to run every X days?"
echo "1) Run once"
echo "2) Schedule to run every X days"
read -p "Enter your choice: " choice

if [ "$choice" -eq 2 ]; then
    read -p "Enter the number of days: " days
    (crontab -l 2>/dev/null; echo "0 0 */$days * * /usr/local/bin/maintenance.sh") | crontab -
    echo "Script scheduled to run every $days days."
else
    echo "Script will run once."
fi

# Make zsh the default shell after reboot
chsh -s $(which zsh)

# Configure neofetch to run at login
if ! grep -Fxq "neofetch" $HOME/.zshrc; then
    echo "neofetch" >> $HOME/.zshrc
fi

# Check if a reboot is needed and schedule it
if [ -f /var/run/reboot-required ]; then
    sudo shutdown -r +5
fi
