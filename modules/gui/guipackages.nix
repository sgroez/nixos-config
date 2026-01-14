{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kitty
    firefox
    yubioath-flutter
  ];

  services.pcscd.enable = true;
}
