{ pkgs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    <package> = https://github.com/sgroez/customNixPackages.git/wvkbd-compact/default.nix { };
  };

  environment.systemPackages = with pkgs; [
    wvkbd-compact
  ];
}
