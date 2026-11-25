{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.kitty;

  configFile = pkgs.writeText "kitty.conf" ''
    confirm_os_window_close 0
    font_family Unifont
    bold_font auto
    italic_font auto
    bold_italic_font auto
    font_size 15.0
    modify_font cell_width 60%
  '';
in
{
  options.kitty = {
    enable = mkEnableOption "enable kitty";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
    stateless.impermanence = lib.mkIf stateless.impermanence.enable {
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
