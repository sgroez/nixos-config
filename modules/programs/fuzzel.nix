{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.fuzzel;
  colors = config.programs.design.colors;
  font = config.programs.design.fonts.main;

  configFile = pkgs.writeText "fuzzel.ini" ''
    [main]
    font=${font.family}:weight=${font.weight}:size=${ lib.toString font.size}
    [colors]
    background=${colors.background}ff
    text=${colors.main}ff
    match=${colors.brightAccent}ff
    selection-match=${colors.brightAccent}ff
    selection=${colors.darkAccent}ff
    selection-text=${colors.main}ff
    border=${colors.brightAccent}ff;
  '';
in
{
  options.fuzzel = {
    enable = lib.mkEnableOption "enable fuzzel";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fuzzel
    ];
    # symlink config file to user home dir
    stateless.impermanence = {
      ensures = [
        {
          path = "/etc/xdg/fuzzel";
          permissions = {
            mode = "0755";
            owner = "root";
            group = "root";
          };
        }
      ];
      links = [
        {
          source = "${configFile}";
          target = "/etc/xdg/fuzzel/fuzzel.ini";
        }
      ];
    };
  };
}
