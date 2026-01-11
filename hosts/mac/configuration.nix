{ config, pkgs, ... }:

{
  imports = [
    ../../modules/base/basepackages.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
