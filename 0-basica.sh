#!/usr/bin/env bash
set -euo pipefail

### Configurando reflector
#Instalando e aplicando
sudo pacman -Syu
sudo pacman --noconfirm -S reflector nano
sudo reflector --country Brazil --protocol https --latest 30 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

### Montando SSDs
# Criando pastas
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
sudo systemctl enable --now fstrim.timer

### Alterando Grub
# Configurando o default grub
sudo sed -i \
  '/^GRUB_CMDLINE_LINUX_DEFAULT=/d;
   /^GRUB_CMDLINE_LINUX=/d;
   /^GRUB_DEFAULT=/d;
   /^GRUB_SAVEDEFAULT=/d;
   /^GRUB_TIMEOUT=/d;
   /^GRUB_TIMEOUT_STYLE=/d;
   /^GRUB_DISABLE_SUBMENU=/d' \
  /etc/default/grub

sudo tee -a /etc/default/grub >/dev/null <<'EOF'
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet zswap.enabled=0 amd_pstate=active mitigations=off transparent_hugepage=madvise"
GRUB_CMDLINE_LINUX="amdgpu.ppfeaturemask=0xffffffff"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT=2
GRUB_TIMEOUT_STYLE=menu
GRUB_DISABLE_SUBMENU=y
EOF

# Instalando Kernel 7.2
sudo pacman --noconfirm -U /home/milhomens/ssd-b/kernel-packages/7.2/*.pkg.tar.zst

# Subindo grub com mkconfig
sudo grub-mkconfig -o /boot/grub/grub.cfg

### Montando Zram-Generator
# Instalando zram-generator
sudo pacman --noconfirm -S zram-generator

# Criando .conf
sudo tee -a /etc/systemd/zram-generator.conf >/dev/null <<'EOF'
[zram0]
zram-size = 49152
compression-algorithm = zstd
EOF

### Otimizando swap/zswap
# Criando a conf
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

# Aplicando a .conf
sudo sysctl --system

### Instalando gamemode
sudo pacman --noconfirm -S gamemode lib32-gamemode

# Criando a conf
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

./0-devel.sh
