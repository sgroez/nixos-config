{
  description = "My modular multi platform NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad/configuration.nix
        ];
      };

      piImage = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ({ modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/sd-card/sd-image-aarch64.nix") ];
          })
          ./hosts/pi/configuration.nix
        ];
      };

      pi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hosts/pi/configuration.nix
        ];
      };
    };
  };
}

