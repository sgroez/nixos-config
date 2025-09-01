{ pkgs, ... }: {
  programs.hyprland.enable = true;

  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    pavucontrol
    fuzzel
    quickshell
    hyprlandPlugins.hyprgrass
    iio-hyprland
  ];
}
