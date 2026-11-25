{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.quickshell;
in
{
  options.quickshell = {
    enable = mkEnableOption "enable quickshell";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
    stateless.impermanence = lib.mkIf stateless.impermanence.enable {
      links = [
        {
          source = "${./quickshell}";
          target = "/etc/xdg/quickshell";
        }
      ];
    };
  };
}
