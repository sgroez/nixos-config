{
  description = "NixOS flake template for system setup with minimal or graphical applications";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    customModules.url = "github:sgroez/nixos-config";
  };

  outputs = { self, nixpkgs, flake-utils, inputs }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system: {
      nixosConfigurations = {
        base = import ./nixos/base.nix { inherit inputs; system = "x86_64-linux"; };
        graphical = import ./nixos/graphical.nix { inherit inputs; system = "x86_64-linux"; };
      };
    });
  }
