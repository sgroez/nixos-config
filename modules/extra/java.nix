{ pkgs, ... }: {
  #nixpkgs.config.allowUnfree = true;
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  environment.systemPackages = with pkgs; [
    maven
  ];
}
