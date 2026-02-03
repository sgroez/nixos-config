{
  imports = [
    ./base/locales.nix
    ./base/fonts.nix
    ./base/basepackages.nix
    ./base/network.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
