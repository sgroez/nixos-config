{ pkgs, ... }: {
  programs.hyprland.enable = true;

  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    pavucontrol
    fuzzel
    waybar
  ];
}
