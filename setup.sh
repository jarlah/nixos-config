mount -t tmpfs none /mnt
mkdir -p /mnt/{boot,nix,etc/nixos,var/log}
mount /dev/disk/by-label/nixos /mnt/nix
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/xps/swap
mkdir -p /mnt/nix/persist/etc/{nixos,var/log}
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos
git clone https://github.com/jarlah/nixos-config.git /mnt/etc/nixos
nixos-generate-config --root /mnt
