{ config, pkgs, ... }:

{
  imports = [
    ../../modules/base/basepackages.nix
  ];

  networking.hostName = "mac";
  system.stateVersion = "25.05";
}
