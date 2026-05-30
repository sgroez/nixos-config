{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.auth.pam;
in
{
  options.auth.pam = {
    enable = lib.mkEnableOption "pam auth";
    authFile = lib.mkOption {
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
        authfile = authFile;
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
