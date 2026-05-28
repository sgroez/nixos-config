{ pkgs, ... }:
let
  cfg = config.profiles.multimedia;
in
{
  options.profiles.multimedia = {
    enable = lib.mkEnableOption "multimedia profile";
    allowUnfree = lib.mkEnableOption "unfree multimedia";
  };

  config =
    mkIf cfg.enable {
      profiles.gui.enable = true;
      environment.systemPackages = with pkgs; [
        gimp
        blender
        audacity
        pdftricks
        imagemagick
        gthumb
      ];

      services.printing.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    }
    // mkIf cfg.allowUnfree {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        google-chrome
      ];
    };
}
