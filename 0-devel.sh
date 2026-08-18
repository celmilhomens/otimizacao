#!/usr/bin/env bash

# Base, sistema e serviços
sudo pacman --needed -S base-devel git linux-headers linux-firmware-amdgpu fastfetch htop btop zram-generator rtkit packagekit-qt6

sudo reboot
