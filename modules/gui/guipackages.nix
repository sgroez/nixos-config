{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    yubioath-flutter
    hyprshot
  ];

  services.pcscd.enable = true;
}
