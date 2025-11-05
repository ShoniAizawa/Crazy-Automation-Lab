
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
