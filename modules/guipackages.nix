{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    google-chrome
    vscode
    yubioath-flutter
  ];

  services.pcscd.enable = true;
}
