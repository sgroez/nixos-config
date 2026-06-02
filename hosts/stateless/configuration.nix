{ config, pkgs, ... }:
let
  persist = "/nix/persist";
  username = "stateless";
in
{
  imports = [
    # Include all modules (enable needed modules below).
    ../../modules
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include the disk config for disko.
    ./disko-config.nix
  ];

  # Configure modules
  auth.pam.enable = true;
  auth.pam.authFile = "${persist}/etc/Yubico/u2f_keys";
  profiles.gui.enable = true;
  profiles.gui.allowUnfree = true;
  profiles.base.hostname = "thinkpad";
  dotfiles = {
    enable = true;
    usernames = [ "${username}" ];
    usergroup = "users";
  };
  extraOptions.powerManagement.enable = true;

  stateless.persist = {
    enable = true;
    binds = [
      {
        source = "${persist}/var/log";
        target = "/var/log";
      }
      {
        source = "${persist}/etc/machine-id";
        target = "/etc/machine-id";
      }
      {
        source = "${persist}/etc/NetworkManager/system-connections";
        target = "/etc/NetworkManager/system-connections";
      }
      {
        source = "${persist}/${username}/.gitconfig";
        target = "/home/${username}/.gitconfig";
      }
      {
        source = "${persist}/${username}/.ssh";
        target = "/home/${username}/.ssh";
      }
      {
        source = "${persist}/${username}/code";
        target = "/home/${username}/code";
      }
      {
        source = "${persist}/${username}/books";
        target = "/home/${username}/books";
      }
    ];
    links = [ ];
    ensures = [ ];
  };

  # Define a user account.
  users = {
    mutableUsers = false;
    allowNoPasswordLogin = true;
    users."${username}" = {
      isNormalUser = true;
      uid = 1000; # set uid to persist with tmpfs root filesystem
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [ ];
    };
  };

  # Configuration version and extra features
  system.stateVersion = "25.11";
}
