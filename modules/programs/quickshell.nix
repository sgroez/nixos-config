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
    enable = lib.mkEnableOption "enable quickshell";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
    stateless.impermanence = {
      links = [
        {
          source = "${./quickshell}";
          target = "/etc/xdg/quickshell";
        }
      ];
    };
  };
}
