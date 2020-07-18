#!/bin/bash

set -e
clear

function abort {
	printf "\n\e[91;1mAborting...\n\e[0m"
}
trap abort EXIT

printf "\n\e[96;1m Welcome to Deluged Kickstart script!\n    > > GitHub.com/NinoM4ster < <\n\n"
read -rsp $'\e[96;1mPress <Enter> to begin...'; clear

printf "\e[37;1mHere's what I am going to do:\n\n"
printf "\e[37;1m> Add the official Deluge 2.X stable repository:\n"
printf "\e[93m   sudo add-apt-repository ppa:deluge-team/stable\n\n"

printf "\e[37;1m> Update the system and install the latest version of Deluged and Deluge-web:\n"
printf "\e[93m   sudo apt update\n   sudo apt install deluged deluge-web\n\n"

printf "\e[37;1m> Create system user for Deluge:\n"
printf "\e[93m   sudo adduser --system --gecos \"\" --disabled-password --group --home /var/lib/deluge deluge\n\n"

printf "\e[37;1m> Create two systemd service files:\n"
printf "\e[93m   /etc/systemd/system/deluged.service\n   /etc/systemd/system/deluge-web.service\n\n"

printf "\e[37;1m> Start and enable both services:\n"
printf "\e[93m   sudo systemctl start deluged\n   sudo systemctl start deluge-web\n   sudo systemctl enable deluged\n   sudo systemctl enable deluge-web\n\n"

read -rsp $'\e[96;1mPress <Enter> to continue or Ctrl + C to abort...'

clear

printf "\n\e[37;1mOkay.. let's do it.\n\n"
printf "\e[93;1m>> sudo add-apt-repository ppa:deluge-team/stable\n\e[0m"
sudo add-apt-repository ppa:deluge-team/stable

printf "\n\e[93;1m>> sudo apt update\n\e[0m"
sudo apt update

printf "\n\e[93;1m>> sudo apt install deluged deluge-web\n\e[0m"
sudo apt install deluged deluge-web

printf "\n\e[93;1m>> sudo adduser --system --gecos \"\" --disabled-password --group --home /var/lib/deluge deluge\n\e[0m"
sudo adduser --system --gecos "" --disabled-password --group --home /var/lib/deluge deluge
sleep 1; printf "Done.\n"

printf "\n\e[93;1m>> Creating systemd service file '/etc/systemd/system/deluged.service'..\n\e[0m"
printf "[Unit]\nDescription=Deluge Bittorrent Client Daemon\nAfter=network-online.target\n[Service]\nType=simple\nUser=deluge\nGroup=deluge\nUMask=007\nExecStart=/usr/bin/deluged -d\nRestart=on-failure\nTimeoutStopSec=300\n[Install]\nWantedBy=multi-user.target\n" | sudo tee /etc/systemd/system/deluged.service >/dev/null
sleep 1; printf "Done.\n"

printf "\n\e[93;1m>> Creating systemd service file '/etc/systemd/system/deluge-web.service'..\n\e[0m"
printf "[Unit]\nDescription=Deluge Bittorrent Client Web Interface\nAfter=network-online.target\n[Service]\nType=simple\nUser=deluge\nGroup=deluge\nUMask=027\nExecStart=/usr/bin/deluge-web\nRestart=on-failure\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/deluge-web.service >/dev/null
sleep 1; printf "Done.\n"

printf "\n\e[93;1m>> sudo systemctl start deluged\n\e[0m"
sudo systemctl start deluged
sleep 1; printf "Done.\n"

printf "\n\e[93;1m>> sudo systemctl start deluge-web\n\e[0m"
sudo systemctl start deluge-web
sleep 1; printf "Done.\n"

printf "\n\e[93;1m>> sudo systemctl enable deluged\n\e[0m"
sudo systemctl enable deluged
sleep 1

printf "\n\e[93;1m>> sudo systemctl enable deluged\n\e[0m"
sudo systemctl enable deluge-web
sleep 1

printf "\n\e[96;1mInstallation successful!\n\nNow try to access the Web-UI:\nhttp://<server ip>:8112\e[0m\n"

trap - EXIT
