{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kitty
    firefox
    yubioath-flutter
    hyprshot
  ];

  services.pcscd.enable = true;
}
