{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false; # Not needed on ARM either
  boot.loader.generic-extlinux-compatible.enable = true;
}
