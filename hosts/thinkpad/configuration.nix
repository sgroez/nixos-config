{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/sim.nix
    ../../modules/desktop.nix
    ../../modules/extra/chrome.nix
    ../../modules/extra/powermanagement.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-ff1ba414-b92f-4d26-8349-c85d36cf5191".device = "/dev/disk/by-uuid/ff1ba414-b92f-4d26-8349-c85d36cf5191";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking.hostName = "thinkpad";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
