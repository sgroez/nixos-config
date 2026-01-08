{ config, pkgs, ... }:

{
  imports = [
    ../../modules/base/basepackages.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
