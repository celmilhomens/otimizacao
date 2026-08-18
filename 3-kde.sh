#!/usr/bin/env bash

# KDE Plasma, Wayland e integração
sudo pacman --needed -S plasma-meta plasma5-integration breeze5 kwayland-integration qt6-wayland xorg-xwayland wayland-utils wl-clipboard

# Aplicativos KDE
sudo pacman --needed -S dolphin ark kate gwenview okular kitty kio-admin kdenetwork-filesharing

# Portais, GTK e compartilhamento
sudo pacman --needed -S xdg-desktop-portal-gtk gtk3 gtk4

# Imagem, miniaturas e mídia
sudo pacman --needed -S ffmpegthumbs kdegraphics-thumbnailers onnxruntime gst-plugins-good gst-plugins-bad gst-libav
