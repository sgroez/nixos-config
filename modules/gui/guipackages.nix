{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wvkbd
    firefox
    yubioath-flutter
  ];

  services.pcscd.enable = true;
}
