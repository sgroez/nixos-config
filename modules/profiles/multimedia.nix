{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.multimedia;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.multimedia = {
    enable = mkEnableOption "multimedia profile";
  };

  config = mkIf cfg.enable {
    profiles.gui.enable = true;
    environment.systemPackages = with pkgs; [
      gimp
      blender
      audacity
      pdftricks
      imagemagick
      gthumb
    ];
  };
}
