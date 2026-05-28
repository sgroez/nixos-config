{
  description = "My modular multi platform NixOS configurations";

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
        thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/thinkpad/configuration.nix
          ];
        };

        piImage = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            (
              { modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/sd-card/sd-image-aarch64.nix") ];
              }
            )
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
