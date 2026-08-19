#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S thunderbird pacman-contrib pacutils
paru --needed --noconfirm -S lug-helper protonplus brave-bin chatgpt-desktop vulkan-low-latency-layer ttf-ms-fonts
paru -S opentrack-git zapzap

sudo reboot
