#!/usr/bin/env bash
set -euo pipefail

cd /home/milhomens
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd /home/milhomens
sudo rm -r paru

./2.1-aur
