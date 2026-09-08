#!/usr/bin/env bash
set -euo pipefail

### Instalando Mesa 26.3.0
# Instalando pacote compilado
sudo pacman -U /home/milhomens/ssd-b/linux/tkg-ready/mesa/26.3.x/*.pkg.tar.zst

# Instalando outros componentes de video
sudo pacman --needed --noconfirm -S mesa-utils vulkan-tools libva-utils corectrl vulkan-headers

sudo tee -a /etc/polkit-1/rules.d/90-corectrl.rules >/dev/null <<'EOF'
polkit.addRule(function(action, subject) {
    if ((action.id == "org.corectrl.helper.init" ||
         action.id == "org.corectrl.helperkiller.init") &&
        subject.local == true &&
        subject.active == true &&
        subject.isInGroup("milhomens")) {
            return polkit.Result.YES;
    }
});
EOF

sudo reboot
