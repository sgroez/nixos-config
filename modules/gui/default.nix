{ pkgs, ... }: {
  # add function that automatically imports all submodules and adds options to toggle them
  # on or off
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
  ];
}
