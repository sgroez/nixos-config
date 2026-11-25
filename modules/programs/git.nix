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
    enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      config = {
        user = {
          name = "sgroez";
          email = "venticx@gmail.com";
        };
      };
    };
  };
}
