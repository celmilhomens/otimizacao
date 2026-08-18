#!/usr/bin/env bash
set -euo pipefail

# Áudio, Bluetooth e controle
sudo pacman --needed -S pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack wireplumber alsa-utils alsa-tools alsa-plugins
