{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    yubioath-flutter
    element-desktop
  ];

  services.pcscd.enable = true;
}
