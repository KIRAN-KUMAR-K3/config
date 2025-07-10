#!/bin/bash

# Add PacketFence repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packetfence-archive-keyring.gpg] https://inverse.ca/downloads/PacketFence/debian bookworm main" | sudo tee /etc/apt/sources.list.d/packetfence.list

# Download and add the GPG key
wget -qO - https://inverse.ca/downloads/GPG_KEY | sudo gpg --dearmor -o /usr/share/keyrings/packetfence-archive-keyring.gpg

# Update package list
sudo apt update

# Install PacketFence
sudo apt install packetfence -y
