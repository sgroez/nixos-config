{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.git;
in
{
  options.git = {
    enable = mkEnableOption "enable git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      settings.user = {
        name = "sgroez";
        email = "venticx@gmail.com";
      };
    };
  };
}
