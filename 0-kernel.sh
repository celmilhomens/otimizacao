### Alterando Grub
# Configurando o default grub
sudo sed -i \
  '/^GRUB_CMDLINE_LINUX_DEFAULT=/d;
   /^GRUB_CMDLINE_LINUX=/d;
   /^GRUB_DEFAULT=/d;
   /^GRUB_SAVEDEFAULT=/d;
   /^GRUB_TIMEOUT=/d;
   /^GRUB_TIMEOUT_STYLE=/d;
   /^GRUB_DISABLE_SUBMENU=/d' \
  /etc/default/grub

sudo tee -a /etc/default/grub >/dev/null <<'EOF'
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet zswap.enabled=0 amd_pstate=active mitigations=off transparent_hugepage=madvise"
GRUB_CMDLINE_LINUX="amdgpu.ppfeaturemask=0xffffffff"
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_TIMEOUT=2
GRUB_TIMEOUT_STYLE=menu
GRUB_DISABLE_SUBMENU=y
EOF

# Instalando Kernel 7.2
sudo pacman --noconfirm -U /home/milhomens/ssd-b/kernel-packages/7.2/*.pkg.tar.zst

# Subindo grub com mkconfig
sudo grub-mkconfig -o /boot/grub/grub.cfg
