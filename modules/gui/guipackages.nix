{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    yubioath-flutter
    element-desktop
    hyprshot
  ];

  services.pcscd.enable = true;
}
