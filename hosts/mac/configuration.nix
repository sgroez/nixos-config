{ config, pkgs, ... }:

{
  imports = [
    ../../modules/base/basepackages.nix
  ];

  networking.hostName = "mac";
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = "25.05";
}
