{
  description = "My modular multi platform NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Mobile-NixOS repository - provides mobile-specific modules and device support
    mobile-nixos = {
      url = "github:mobile-nixos/mobile-nixos";
      flake = false; # We import it directly, not as a flake
    };
  };

  outputs = { self, nixpkgs, mobile-nixos, ... }: {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad/configuration.nix
        ];
      };

      oneplus = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          (import "${mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
          ({ nixpkgs.config.allowUnfree = true; })
          ./hosts/oneplus/configuration.nix
        ];
      };

      xeondesktopIso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ({ config, modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
          })
          ./hosts/xeondesktop/configuration.nix
        ];
      };

      xeondesktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/xeondesktop/configuration.nix
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

