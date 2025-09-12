{ pkgs, ... }: {
  nixpkgs.overlays = [
    (import ../../overlays/customNixPackages.nix)
  ];

  environment.systemPackages = with pkgs; [
    wvkbd-compact
  ];
}
