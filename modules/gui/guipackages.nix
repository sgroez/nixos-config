{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    yubioath-flutter
  ];

  services.pcscd.enable = true;
}
