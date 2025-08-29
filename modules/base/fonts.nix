{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    material-symbols
  ];
}
