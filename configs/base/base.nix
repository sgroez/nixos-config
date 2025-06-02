{ inputs, system }:inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../../shared/configuration.nix
    inputs.disko.nixosModules.disko
    ../../shared/disko.nix
    (import "${inputs.customModules}/modules/basepackages.nix")
  ];
}
