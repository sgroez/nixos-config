{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.gui;
in
{
  options.profiles.gui = {
    enable = lib.mkEnableOption "gui profile";
  };

  config = mkIf cfg.enable {
    profiles.base.enable = true;

    programs.hyprland.enable = true;
    services.upower.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
      brightnessctl
      pavucontrol
      fuzzel
      quickshell
      hyprshot
      firefox
      yubioath-flutter
    ];
    services.pcscd.enable = true;
  };
}
