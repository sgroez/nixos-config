{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    google-chrome
    vscode
    gimp
    blender
    audacity
  ];

  programs.steam = {
    enable = true;
  };
}
