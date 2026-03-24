{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gimp
    blender
    audacity
    pdftricks
    imagemagick
    gthumb
  ];
}
