{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    google-chrome
    gimp
    blender
    audacity
    pdftricks
    imagemagick
    kicad
    cmus
    gthumb
  ];
}
