{ pkgs, ... }:
let
  cfg = config.profiles.gaming;
in
{
  options.profiles.gaming = {
    enable = lib.mkEnableOption "gaming profile";
  };

  config = mkIf cfg.enable {
    profiles.gui.enable = true;
    nixpkgs.config.allowUnfree = true;
    programs.steam = {
      enable = true;
    };
  };
}
