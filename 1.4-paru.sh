#!/usr/bin/env bash
set -euo pipefail

cd /home/milhomens
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd /home/milhomens

./2.1-aur
