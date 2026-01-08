{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    kitty
    git
    gh
    stow
    neovim
    tealdeer
    cmus
  ];
}
