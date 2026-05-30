{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.extraOptions.powerManagement;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.extraOptions.powerManagement = {
    enable = mkEnableOption "extraOption powerManagement";
  };

  config = mkIf cfg.enable {
    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
