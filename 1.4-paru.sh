#!/usr/bin/env bash
set -euo pipefail

cd /home/milhomens
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd /home/milhomens
sudo rm -r paru

./2.1-aur
