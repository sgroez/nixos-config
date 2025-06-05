{ system, customModules }:inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../shared/configuration.nix
    (import "${customModules}/basepackages.nix")
  ];
}
