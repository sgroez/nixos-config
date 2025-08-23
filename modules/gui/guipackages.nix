{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    vscode
    yubioath-flutter
  ];

  services.pcscd.enable = true;
}
