{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.fuzzel;

  configFile = pkgs.writeText "fuzzel.ini" ''
    [main]
    font=Unifont:weight=regular:size=20
    [colors]
    background=000000ff
    text=faba38ff
    match=ffee4fff
    selection-match=ffee4fff
    selection=a06419ff
    selection-text=faba38ff
    border=ffee4fff;
  '';
in
{
  options.fuzzel = {
    enable = mkEnableOption "enable fuzzel";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fuzzel
    ];
    # symlink config file to user home dir
    stateless.impermanence = lib.mkIf stateless.impermanence.enable {
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
