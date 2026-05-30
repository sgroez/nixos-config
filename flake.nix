{
  description = "My nixos configurations for all current used devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }:
    let
      lib = nixpkgs.lib;
      myLib = import ./lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      formatter = lib.genAttrs systems (system: (import nixpkgs { inherit system; }).nixfmt-tree);
    in
    {
      inherit formatter;
      nixosConfigurations = {
        stateless = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
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
