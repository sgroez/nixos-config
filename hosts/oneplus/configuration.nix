{ config, pkgs, ... }:

{
  imports = [
    ../../users/sim.nix
    ../../modules/base.nix
    ../../modules/extra/bluetooth.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "oneplus";

  # Disable cpufreq to avoid error with gnome power profile management
  services.auto-cpufreq.enable = false;

  # Enable GNOME Desktop Environment
  services.xserver.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

   # Enable dconf for GNOME settings
  programs.dconf.enable = true;

# Remove unwanted GNOME applications
  environment.gnome.excludePackages = with pkgs; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager
    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
    gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  ];

  networking.modemmanager.enable = true;
  systemd.services.ModemManager.enable = true;

  # Enable SSH server (essential for mobile device access)
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
