{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/extra/powermanagement.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices."luks-ff1ba414-b92f-4d26-8349-c85d36cf5191".device = "/dev/disk/by-uuid/ff1ba414-b92f-4d26-8349-c85d36cf5191";
  };

  users.users.sim = {
    isNormalUser = true;
    description = "sim";
    initialPassword = "password";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  networking.hostName = "thinkpad";
  system.stateVersion = "25.05";
}
