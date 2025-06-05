{
  description = "NixOS flake template for system setup with minimal or graphical applications";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    customModules.url = "github:sgroez/nixos-config";
  };

  outputs = { self, nixpkgs, flake-utils, customModules }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system: {
      nixosConfigurations = {
        base = import ./nixos/base.nix { system = "x86_64-linux"; inherit customModules; };
        graphical = import ./nixos/graphical.nix { system = "x86_64-linux"; inherit customModules; };
      };
    });
  }
