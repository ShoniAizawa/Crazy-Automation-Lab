#!/bin/bash
# auto_start.sh - Auto Tethering Boot Service
# Jalankan saat boot, aktifkan auto tethering

echo "[$(date)] Auto Tethering: Service dimulai..." > /data/data/com.termux/files/home/tether.log

# Hapus service lama kalau ada
rm -f /data/adb/service.d/auto_tether_boot.sh

# Buat service baru
cat > /data/adb/service.d/auto_tether_boot.sh << 'EOF'
#!/system/bin/sh

sleep 40
termux-wake-lock
nohup sh /data/data/com.termux/files/home/auto_tether.sh > /data/data/com.termux/files/home/tether.log 2>&1 &
EOF

# Izin eksekusi
chmod 755 /data/adb/service.d/auto_tether_boot.sh

echo "[$(date)] Auto Tethering: Service terpasang. Reboot untuk aktifkan!" >> /data/data/com.termux/files/home/tether.log
