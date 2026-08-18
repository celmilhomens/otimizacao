#!/usr/bin/env bash
set -euo pipefail

### Configurando o pacman.conf
PACMAN_CONF="/etc/pacman.conf"
BACKUP="${PACMAN_CONF}.bak"

# Cria o backup somente se ainda não existir
if [[ ! -f "$BACKUP" ]]; then
    sudo cp "$PACMAN_CONF" "$BACKUP"
fi

# Habilita ILoveCandy
if ! grep -qE '^[[:space:]]*ILoveCandy[[:space:]]*$' "$PACMAN_CONF"; then
    sudo sed -i '/^\[options\]/a ILoveCandy' "$PACMAN_CONF"
fi

# Define ParallelDownloads para 30
if grep -qE '^[[:space:]#]*ParallelDownloads[[:space:]]*=' "$PACMAN_CONF"; then
    sudo sed -i -E \
        's/^[[:space:]#]*ParallelDownloads[[:space:]]*=.*/ParallelDownloads = 30/' \
        "$PACMAN_CONF"
else
    sudo sed -i '/^\[options\]/a ParallelDownloads = 30' "$PACMAN_CONF"
fi

### Instalando pacotes essenciais ao script
sudo pacman --needed --noconfirm -S reflector nano zram-generator gamemode lib32-gamemode base-devel linux-headers linux-firmware-amdgpu fastfetch htop

### Configurando reflector
sudo reflector --country Brazil --protocol https --latest 30 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

### Montando SSDs
# Criando pastas
cd /home/milhomens
mkdir ssd-a
mkdir ssd-b

# Alterando fstab
sudo tee -a /etc/fstab >/dev/null <<'EOF'
/dev/nvme0n1p2  none  swap  defaults  0  0
/dev/sda1  /home/milhomens/ssd-a  ext4  defaults,noatime  0  2
/dev/sdb1  /home/milhomens/ssd-b  ext4  defaults,noatime  0  2
EOF

# Aplicando fstab
sudo mount -a
sudo swapon -a

#Retornando
cd /home/milhomens

### Instalando Zram-Generator
# Criando .conf
sudo tee -a /etc/systemd/zram-generator.conf >/dev/null <<'EOF'
[zram0]
zram-size = 49152
compression-algorithm = zstd
EOF

# Otimizando a conf
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

# Aplicando a conf
sudo sysctl --system

### Instalando gamemode
# Criando a conf
sudo tee -a /etc/gamemode.ini >/dev/null <<'EOF'
[general]
desiredgov=performance
desiredprof=performance
softrealtime=off
renice=10
ioprio=0
inhibit_screensaver=1
disable_splitlock=0
EOF

sudo reboot

