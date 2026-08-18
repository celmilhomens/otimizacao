#!/usr/bin/env bash
set -euo pipefail

# Jogos e comunicação
sudo pacman --needed -S steam goverlay gamescope mangohud lib32-mangohud discord firefox

./1.3-yay.sh
