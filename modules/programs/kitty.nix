{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.kitty;
  font = config.programs.design.fonts.main;

  configFile = pkgs.writeText "kitty.conf" ''
    confirm_os_window_close 0
    font_family ${font.family}
    bold_font auto
    italic_font auto
    bold_italic_font auto
    font_size ${lib.toString font.size}
    modify_font cell_width 60%
  '';
in
{
  options.kitty = {
    enable = lib.mkEnableOption "enable kitty";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
    stateless.impermanence = {
      ensures = [
        {
          path = "/etc/xdg/kitty";
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
          target = "/etc/xdg/kitty/kitty.conf";
        }
      ];
    };
  };
}
