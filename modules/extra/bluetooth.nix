{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.extraOptions.bluetooth;
in
{
  options.extraOptions.bluetooth = {
    enable = lib.mkEnableOption "extraOption bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
