{
  description = "Stateless system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko }: {
    nixosConfigurations = {
      stateless = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	  disko.nixosModules.disko
	];
      };
    };
  };
}
