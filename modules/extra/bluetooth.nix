{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.extraOptions.bluetooth;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.extraOptions.bluetooth = {
    enable = mkEnableOption "extraOption bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
