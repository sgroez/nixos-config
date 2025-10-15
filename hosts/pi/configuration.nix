# inspired by github.com/plmercereau/nixos-pi-zero-2
{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../modules/base.nix
    ../../modules/extra/powermanagement.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi02w;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      systemd-boot.enable = false;
      grub.enable = false; # Not needed on ARM either
      generic-extlinux-compatible.enable = true;
    };
    swraid.enable = lib.mkForce false;
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  system.stateVersion = "25.05";

  # Some packages (ahci fail... this bypasses that) https://discourse.nixos.org/t/does-pkgs-linuxpackages-rpi3-build-all-required-kernel-modules/42509
  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
    })
  ];

  users.users = {
    pi = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "password";
      openssh.authorizedKeys.keys = [
        (builtins.readFile ~/.ssh/id_ed25519.pub)
      ];
    };
    root = {
      hashedPassword = "*";
      openssh.authorizedKeys.keys = [
        (builtins.readFile ~/.ssh/id_ed25519.pub)
      ];
    };
  };

  environment.etc."NetworkManager/system-connections/groezbox.nmconnection" = {
    source = ~/secrets/groezbox.nmconnection;
    mode = "0600";
    user = "root";
    group = "root";
  };

  environment.etc."NetworkManager/system-connections/groezbox2.nmconnection" = {
    source = ~/secrets/groezbox2.nmconnection;
    mode = "0600";
    user = "root";
    group = "root";
  };

  networking.hostName = "pi";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;


  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = false;
}
