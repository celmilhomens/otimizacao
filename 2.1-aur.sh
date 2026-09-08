#!/usr/bin/env bash
set -euo pipefail

sudo pacman --needed -S thunderbird pacman-contrib pacutils onnxruntime
paru --needed --noconfirm -S lug-helper protonplus brave-bin chatgpt-desktop vulkan-low-latency-layer ttf-ms-fonts
paru -S opentrack-git zapzap lsfg-vk-bin

sudo reboot
