#!/usr/bin/env bash

# Base, sistema e serviços
sudo pacman --needed --noconfirm -S base-devel linux-headers linux-firmware-amdgpu fastfetch
sudo reboot
