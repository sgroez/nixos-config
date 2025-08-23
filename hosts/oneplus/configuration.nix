{ config, pkgs, ... }:

{
  imports = [
    ../../users/sim.nix
    ../../modules/gui.nix
  ];

  nixpkgs.config.allowUnfree = true;

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
