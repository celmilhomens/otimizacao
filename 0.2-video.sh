#!/usr/bin/env bash
set -euo pipefail

### Instalando Mesa 26.3.0
# Instalando pacote compilado
sudo pacman -U /home/milhomens/ssd-b/linux/tkg-ready/mesa/26.3.0/*.pkg.tar.zst

# Instalando outros componentes de video
sudo pacman --needed --noconfirm -S mesa-utils vulkan-tools libva-utils corectrl vulkan-headers

sudo reboot
