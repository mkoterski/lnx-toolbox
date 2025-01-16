temp.txt



## Updates and upgrades + automatic removal of unnecessary packages
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

## add fastfetch repo:
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

## Install fastfetch:
sudo apt update && sudo apt install fastfetch -y

## Generate config file as it is not automatically created:
fastfetch --gen-config

## config file will be saved in ~/.config/fastfetch/config.jsonc