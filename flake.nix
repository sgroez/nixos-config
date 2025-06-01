{
  description = "NixOS flake template for system setup with minimal or graphical applications";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    customModules.url = "github:sgroez/nixos-config";
  };

  outputs = { self, nixpkgs, ... }: let
    sharedConfig = {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.05";

      time.timeZone = "Europe/Berlin";
      i18n.defaultLocale = "en_US.UTF8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
      };

      services.xserver.xkb = {
	layout = "de";
	variant = "";
      };

      console.keyMap = "de";

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      #TODO change username to your desired username and set password using cmdline
      users.users.username = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
	password = "password";
      };

      #TODO change hostname to your desired hostname
      networking.hostName = "nixos";
      networking.networkmanager.enable = true;
      networking.firewall.enable = true;
      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
    };
  {
    nixosConfigurations = {
      base = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  sharedConfig
          "${customModules}/modules/basepackages.nix"
        ];
      };

      graphical = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          sharedConfig
          "${customModules}/modules/basepackages.nix"
          "${customModules}/modules/wm.nix"
          "${customModules}/modules/guipackages.nix"
	];
      };
    };
  };
}

