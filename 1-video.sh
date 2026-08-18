#!/usr/bin/env bash

# Instalando Mesa 26.3.0
sudo pacman --noconfirm -U /home/milhomens/ssd-b/kernel-packages/mesa/26.3.0/*.pkg.tar.zst
# Instalando outros componentes de video
sudo pacman --needed -S mesa-utils vulkan-tools libva-utils corectrl vulkan-headers

./2-audio.sh
