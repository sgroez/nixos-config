{ inputs, system }:inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../shared/configuration.nix
    (import "${inputs.customModules}/modules/basepackages.nix")
  ];
}
