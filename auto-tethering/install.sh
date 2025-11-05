#!/bin/bash
echo "Installing Auto Tethering - Crazy Automation Lab"

# Cek root
if ! command -v su &> /dev/null; then
    echo "Root tidak terdeteksi! Install Magisk dulu."
    exit 1
fi

# Install dependencies
pkg install termux-api jq -y

# Download script
mkdir -p ~/crazy-automation
curl -L https://raw.githubusercontent.com/ShoniAizawa/Crazy-Automation-Lab/main/auto-tethering/auto_tether.sh -o ~/crazy-automation/auto_tether.sh
chmod +x ~/crazy-automation/auto_tether.sh

# Jadwalkan tiap 3 menit
(crontab -l 2>/dev/null; echo "*/3 * * * * ~/crazy-automation/auto_tether.sh") | crontab -

echo "Auto Tethering aktif! Cek log: tail -f ~/crazy-automation.log"
