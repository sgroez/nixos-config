{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./persist.nix
      ./dotfiles.nix
      ./disko-config.nix
      ./unfree.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Yubikey login and sudo
  security.pam.u2f = {
    enable = true;
    settings = {
      interactive = true;
      cue = true;
      pinverification = 1;
      authfile = "/nix/persist/etc/Yubico/u2f_keys";
    };
  };

  security.pam.services = {
    login = {
      u2fAuth = true;
      unixAuth = false;
    };
    sudo = {
      u2fAuth = true;
      unixAuth = false;
    };
  };

  # Networking
  networking = {
    hostName = "stateless";
    networkmanager.enable = true;
  # firewall.allowedTCPPorts = [ ... ];
  # firewall.allowedUDPPorts = [ ... ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";

  # Define a user account.
  users = {
    mutableUsers = false;
    allowNoPasswordLogin = true;
    users.stateless = {
      isNormalUser = true;
      uid = 1000; # set uid to persist with tmpfs root filesystem
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        neovim
        tor-browser
        koreader
      ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    kitty
    fuzzel
    git
    gh
  ];

  # WM
  programs.hyprland.enable = true;

  # Configuration version and extra features
  system.stateVersion = "25.11";
  nix.settings.experimental-features = ["nix-command" "flakes" ];
}

