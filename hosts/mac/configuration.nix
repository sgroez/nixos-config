{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    stow
    neovim
    tealdeer
    cmus
    lynx
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
