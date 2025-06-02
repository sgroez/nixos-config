{
  description = "NixOS flake template for system setup with minimal or graphical applications";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    disko.url = "github:nix-community/disko";
    customModules.url = "github:sgroez/nixos-config";
  };

  outputs = { self, nixpkgs, flake-utils, disko, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

	makeInstallScript = configName: ''
          set -e
          echo "Partitioning..."
          nix run ${disko}/#disko -- --mode disko ./disko.nix
          echo "Mounting..."
          nix run ${disko}/#disko -- --mode mount ./disko.nix
          echo "Installing NixOS..."
          nixos-install --flake "${PWD}#${configName}" --no-root-password
          echo "Install complete!"
        '';
      in {
        # Installation scripts for each host
        packages = {
          install-base = pkgs.writeShellScriptBin "install-base" (makeInstallScript "base");
          install-graphical = pkgs.writeShellScriptBin "install-graphical" (makeInstallScript "graphical");
        };
      }
    ) // {
    nixosConfigurations = {
      base = import ./nixos/base.nix { inherit inputs; system = "x86_64-linux"; };
      graphical = import ./nixos/graphical.nix { inherit inputs; system = "x86_64-linux"; };
    };
  };
}

