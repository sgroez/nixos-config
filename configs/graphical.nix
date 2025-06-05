{ system, customModules }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../shared/configuration.nix
    (import "${customModules}/basepackages.nix")
    (import "${customModules}/wm.nix")
    (import "${customModules}/guipackages.nix")
  ];
}
