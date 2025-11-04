# Crazy-Automation-Phone

This repository contains a collection of automation scripts to turn your phone into a modem or for other automation needs.
Search and use according to your needs.

---
Ensure your phone is rooted and has a root app installed, such as Magisk, SuperSU, KingRoot, or similar.
---

## 🔗 Auto Tethering
Open the Termux app, making sure it comes from F-Droid.
First, we will create a shell file using nano, which we will fill with the auto tethering script.

1. Copy and paste the following command:
```
nano ~/auto_tether.sh
```
2. Then fill in the file with the following commands:
make sure it is in the following file `#!/data/data/com.termux/files/home/auto_tether.sh`
```
# Run As Root
su -c '
echo "Auto Tethering: Monitoring USB..." > /data/data/com.termux/files/home/tether.log

last_state=""

while true; do
    state=$(cat /sys/class/android_usb/android0/state 2>/dev/null || echo "UNKNOWN")
    
    if [ "$state" = "CONFIGURED" ] && [ "$last" != "CONFIGURED" ]; then
        echo "[$(date)] USB PC DETECTED → TETHERING ON" >> ~/tether.log
        service call connectivity 33 i32 1
        settings put global tether_dun_required 0
        svc usb setFunctions rndis
        ip link set rndis0 up 2>/dev/null || true
    elif [ "$state" != "CONFIGURED" ] && [ "$last" = "CONFIGURED" ]; then
        echo "[$(date)] USB LEPAS → TETHERING OFF" >> ~/tether.log
        service call connectivity 33 i32 0
        svc usb setFunctions none
    fi
    
    last_state="$state"
    sleep 2
done
```
Then save it, press Ctrl + X, then press y to save, then press Enter. This is done in Termux.
You have enabled the automatic tethering feature when connecting to a PC/laptop/STB-OpenWRT device.

3.
```
chmod +x ~/auto_tether.sh
```


