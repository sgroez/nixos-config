{ pkgs, ... }:
let
  cfg = config.profiles.multimedia;
in
{
  options.profiles.multimedia = {
    enable = lib.mkEnableOption "multimedia profile";
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
