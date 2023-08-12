#!/bin/bash

# Check if the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Update package information
apt update

# Install essential packages
apt install -y build-essential git curl wget

# Install Python and pip
apt install -y python3 python3-pip

# Install and configure your desired apps
# Install VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
apt update
apt install -y code

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt install -y nodejs

# Install Docker
apt install -y apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# Install Kitty terminal
apt install -y kitty

# Set Kitty as the default terminal
update-alternatives --set x-terminal-emulator /usr/bin/kitty

# Install Nala file manager
git clone https://github.com/dylanaraps/nala.git /opt/nala
ln -s /opt/nala/nala /usr/local/bin/nala

# Install Go (Golang) 1.20
wget https://golang.org/dl/go1.20.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile

# Install AnonSurf utility
git clone https://github.com/Und3rf10w/anonsurf.git /opt/anonsurf
ln -s /opt/anonsurf/anonsurf /usr/local/bin/anonsurf

# Install neofetch
apt install -y neofetch

# Clean up
apt autoremove -y
apt clean

# Reboot the system
reboot

echo "Installation complete. The system will now reboot."
