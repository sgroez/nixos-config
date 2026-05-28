{
  description = "My nixos configurations for all current used devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
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
          modules = [
            ./hosts/stateless/configuration.nix
          ];
        };
      };
    };
}
