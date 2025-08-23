{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    svkbd
    firefox
    yubioath-flutter
  ];

  services.pcscd.enable = true;
}
