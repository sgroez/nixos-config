{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.gui;
  inherit (lib) mkEnableOption mkIf mkMerge;
in
{
  options.profiles.gui = {
    enable = mkEnableOption "gui profile";
    allowUnfree = mkEnableOption "unfree multimedia";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      profiles.base.enable = true;

      hyprland.enable = true;
      quickshell.enable = true;
      fuzzel.enable = true;
      kitty.enable = true;
      firefox.enable = true;
      services.upower.enable = true;

      environment.systemPackages = with pkgs; [
        brightnessctl
        pavucontrol
        hyprshot
        yubioath-flutter
      ];

      services.pcscd.enable = true;

      services.printing.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    }
    (mkIf cfg.allowUnfree {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        google-chrome
      ];
    })
  ]);
}
