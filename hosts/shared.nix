{
  imports = [
    ../nixos-modules/locales.nix
    ../modules/basepackages.nix
    ../modules/network.nix
    ../modules/powermanagement.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
