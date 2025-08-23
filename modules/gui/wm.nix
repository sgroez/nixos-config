{ pkgs, ... }: {
  programs.hyprland.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    pavucontrol
    fuzzel
    waybar
  ];
}
