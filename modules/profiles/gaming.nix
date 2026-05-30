{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.gaming;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.gaming = {
    enable = mkEnableOption "gaming profile";
  };

  config = mkIf cfg.enable {
    profiles.gui.enable = true;
    nixpkgs.config.allowUnfree = true;
    programs.steam = {
      enable = true;
    };
  };
}
