{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.extraOptions.javelinKeyboard;
in
{
  options.extraOptions.javelinKeyboard = {
    enable = lib.mkEnableOption "extraOption javelinKeyboard";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="hidraw", KERNELS=="*:9000:400D.*", MODE="0666"
    '';
  };
}
