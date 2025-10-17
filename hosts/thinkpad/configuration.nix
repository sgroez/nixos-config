{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop.nix
    ../../modules/extra/powermanagement.nix
    ../../modules/extra/huaweiusbmodem.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices."luks-ff1ba414-b92f-4d26-8349-c85d36cf5191".device = "/dev/disk/by-uuid/ff1ba414-b92f-4d26-8349-c85d36cf5191";

    binfmt.emulatedSystems = [ "aarch64-linux" ];
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
