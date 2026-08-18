#!/usr/bin/env bash
set -euo pipefail

cd /home/milhomens
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /home/milhomens

./1.4-paru.sh
