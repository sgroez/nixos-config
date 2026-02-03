{
  imports = [
    ./locales.nix
    ./fonts.nix
    ./basepackages.nix
    ./network.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
