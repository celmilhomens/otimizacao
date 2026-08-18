#!/usr/bin/env bash

mkdir ssd-a
mkdir ssd-b

sudo tee -a /etc/fstab >/dev/null <<'EOF'
/dev/nvme0n1p2  none  swap  defaults  0  0
/dev/sda1  /home/milhomens/ssd-a  ext4  defaults,noatime  0  2
/dev/sdb1  /home/milhomens/ssd-b  ext4  defaults,noatime  0  2
EOF

sudo tee -a /etc/systemd/zram-generator.conf >/dev/null <<'EOF'
[zram0]
zram-size = 49152
compression-algorithm = zstd
EOF

sudo tee -a /etc/sysctl.d/99-vm-zram-parameters.conf >/dev/null <<'EOF'
vm.swappiness = 180
vm.page-cluster = 0
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.dirty_background_ratio = 3
vm.dirty_ratio = 10
vm.vfs_cache_pressure = 50
vm.vfs_cache_pressure_denom = 100
EOF

tee "$HOME/.config/gamemode.ini" >/dev/null <<'EOF'
[general]
desiredgov=performance
desiredprof=performance
softrealtime=off
renice=10
ioprio=0
inhibit_screensaver=1
disable_splitlock=0
EOF

sudo mount -a
sudo swapon -a
sudo sysctl --system
