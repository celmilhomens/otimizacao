#!/bin/bash

sudo pacman -S onnxruntime thunderbird pacman-contrib pacutils
paru --needed --noconfirm -S lug-helper protonplus brave-bin chatgpt-desktop vulkan-low-latency-layer ttf-ms-fonts
paru -S opentrack zapzap

git clone https://github.com/dhruv8sh/arch-update-checker
rm -rf ~/.local/share/plasma/plasmoids/org.kde.archupdatechecker/
cp -r arch-update-checker/ ~/.local/share/plasma/plasmoids/org.kde.archupdatechecker
systemctl --user restart plasma-plasmashell
