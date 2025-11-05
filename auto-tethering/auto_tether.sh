
#!/bin/bash
# Auto Tethering - Crazy Automation Lab
# Aktifkan tethering kalau WiFi mati

WIFI_SSID=$(termux-wifi-connectioninfo | jq -r '.ssid // empty')
TETHER_STATUS=$(su -c 'service call connectivity 33' 2>/dev/null | grep -q '1' && echo "on" || echo "off")

if [[ -z "$WIFI_SSID" ]] && [[ "$TETHER_STATUS" == "off" ]]; then
    echo "[$(date)] WiFi mati → Nyalain tethering..."
    su -c 'service call connectivity 33 i32 1'
elif [[ -n "$WIFI_SSID" ]] && [[ "$TETHER_STATUS" == "on" ]]; then
    echo "[$(date)] WiFi nyala → Matikan tethering..."
    su -c 'service call connectivity 33 i32 0'
fi
