#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

#!/bin/bash
set -e  # exit if a command fails

# System update
 echo "Installing system updates"
 echo "Updating and upgrading your system..."
 sudo apt update && sudo apt upgrade -y


echo "Installing core tools and applications..."

# Node.js (Best installed via apt for system-wide access)
sudo apt install -y nodejs

# Flox 
curl -Lo /tmp/flox.deb https://downloads.flox.dev/by-env/stable/deb/flox-1.5.1.x86_64-linux.deb
sudo dpkg -i /tmp/flox.deb || sudo apt install -f -y

# Git (Core tool, best installed via apt)
sudo apt install -y git

# GitHub Desktop ( Flatpak version) 
echo "Installing GitHub Desktop via Flatpak..."
flatpak install -y flathub io.github.shiftey.Desktop

# Spotify  ( Flatpak version
echo "Installing Spotify via Flatpak..."
flatpak install -y flathub com.spotify.Client

# Visual Studio Code 
curl -Lo /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo apt install -y /tmp/code.deb || sudo apt install -f -y

echo "Script finished!"