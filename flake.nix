{
  description = "My nixos configurations for all current used devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      disko,
      ...
    }:
    let
      myLib = import ./lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems; # partially apply function for easier use
    in
    {
      formatter = forAllSystems (system: (import nixpkgs { inherit system; }).nixfmt-tree);
      nixosConfigurations = {
        stateless = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;
            inherit myLib;
          };
          modules = [
            ./hosts/stateless/configuration.nix
            disko.nixosModules.disko
          ];
        };
      };
    };
}
