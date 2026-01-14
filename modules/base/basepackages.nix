{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    gh
    stow
    neovim
    tealdeer
    cmus
    lynx
  ];
}
