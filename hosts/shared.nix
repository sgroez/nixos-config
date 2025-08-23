{
  imports = [
    ../modules/locales.nix
    ../modules/basepackages.nix
    ../modules/network.nix
    ../modules/powermanagement.nix
    ../modules/print.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
