{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.quickshell;
  fonts = config.programs.design.fonts;
  colors = config.programs.design.colors;

  configDir = pkgs.runCommand "combine-config" {} ''
    mkdir -p $out

    cp -r ${./quickshell}/* $out/
    cat << 'EOF' > $out/bar.json
    {
      "appearance": {
        "hasNotch": false,
        "fonts": {
          "text": {
            "family": "${fonts.main.family}",
            "style": "${fonts.main.weight}",
            "pixelSize": ${lib.toString fonts.main.size}
          },
          "icon": {
            "family": "${fonts.icon.family}",
            "style": "${fonts.icon.weight}",
            "pixelSize": ${lib.toString fonts.icon.size}
          }
        },
        "colors": {
          "main": {
            "hex": "#${colors.main}"
          },
          "darkAccent": {
            "hex": "#${colors.darkAccent}"
          },
          "brightAccent": {
            "hex": "#${colors.brightAccent}"
          }
        }
      }
    }
    EOF
  '';
in
{
  options.quickshell = {
    enable = lib.mkEnableOption "enable quickshell";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
    stateless.impermanence = {
      links = [
        {
          source = "${configDir}";
          target = "/etc/xdg/quickshell";
        }
      ];
    };
  };
}
