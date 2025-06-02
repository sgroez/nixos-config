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
      in {
        packages.installScript = pkgs.writeShellScriptBin "install-nixos" ''
          set -e

          echo "[1/4] Running disko..."
          nix run ${disko}/#disko -- --mode disko ./disko.nix

          echo "[2/4] Mounting partitions..."
          nix run ${disko}/#disko -- --mode mount ./disko.nix

          echo "[3/4] Installing NixOS..."
          nixos-install --flake .

          echo "[4/4] Done!"
        '';
      }
    ) // {
    nixosConfigurations = {
      base = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./configuration.nix
          "${customModules}/modules/basepackages.nix"
        ];
      };

      graphical = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./configuration.nix
          "${customModules}/modules/basepackages.nix"
          "${customModules}/modules/wm.nix"
          "${customModules}/modules/guipackages.nix"
	];
      };
    };
  };
}

