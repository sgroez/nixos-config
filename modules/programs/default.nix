{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./git.nix
    ./neovim.nix
    ./hyprland.nix
    ./quickshell.nix
    ./fuzzel.nix
    ./kitty.nix
    ./firefox.nix
  ];
  stateless.impermanence = lib.mkIf stateless.impermanence.enable {
    ensures = [
      {
        path = "/etc/xdg";
        permissions = {
          mode = "0755";
          owner = "root";
          group = "root";
        };
      }
    ];
  };
}
