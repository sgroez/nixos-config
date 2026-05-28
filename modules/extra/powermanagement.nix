{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.extraOptions.powerManagement;
in
{
  options.extraOptions.powerManagement = {
    enable = lib.mkEnableOption "extraOption powerManagement";
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
