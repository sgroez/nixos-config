{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs;

  fontType = lib.types.submodule {
    options = {
      family = lib.mkOption {
        type = lib.types.str;
      };
      weight = lib.mkOption {
        type = lib.types.str;
      };
      size = lib.mkOption {
        type = lib.types.int;
      };
    };
  };

  designType = lib.types.submodule {
    options = {
      fonts.main = lib.mkOption {
        type = fontType;
        default = {
          family = "Unifont";
          weight = "Regular";
          size = 15;
        };
      };
      fonts.icon = lib.mkOption {
        type = fontType;
        default = {
          family = "Material Symbols Rounded";
          weight = "";
          size = 14;
        };
      };
      colors.main = lib.mkOption {
        type = lib.types.str;
        default = "faba38";
      };
      colors.darkAccent = lib.mkOption {
        type = lib.types.str;
        default = "a06419";
      };
      colors.brightAccent = lib.mkOption {
        type = lib.types.str;
        default = "ffee4f";
      };
      colors.background = lib.mkOption {
        type = lib.types.str;
        default = "000000";
      };
    };
  };
in
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

  options.programs = {
    design = lib.mkOption {
      type = designType;
    };
  };

  config = {
    stateless.impermanence = {
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
  };
}
