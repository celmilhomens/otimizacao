#!/usr/bin/env bash

# AMD, Vulkan e compatibilidade 32-bit
sudo pacman --needed -S mesa-utils vulkan-tools libva-utils corectrl vulkan-headers

./2-audio.sh
