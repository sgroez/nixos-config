{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    jetbrains-mono
    font-awesome
  ];
}
