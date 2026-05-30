{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.auth.pam;
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
in
{
  options.auth.pam = {
    enable = mkEnableOption "pam auth";
    authFile = mkOption {
      type = types.path;
    };
  };

  config = mkIf cfg.enable {
    security.pam.u2f = {
      enable = true;
      settings = {
        interactive = true;
        cue = true;
        pinverification = 1;
        authfile = cfg.authFile;
      };
    };

    security.pam.services = {
      login = {
        u2fAuth = true;
        unixAuth = false;
      };
      sudo = {
        u2fAuth = true;
        unixAuth = false;
      };
    };
  };
}
