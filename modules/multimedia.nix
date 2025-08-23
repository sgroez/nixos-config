{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gimp
    blender
    audacity
  ];
}
