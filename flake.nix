{
  description = "My modular multi platform NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      sharedConfig = { config, pkgs, ... }: {
        system.stateVersion = "25.05";
        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nixpkgs.config.allowUnfree = true;

        time.timeZone = "Europe/Berlin";
        i18n.defaultLocale = "en_US.UTF-8";
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

        #TODO change username to your username and set password after first boot using cmdline
        users.users.username = {
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          password = "password";
          openssh.authorizedKeys.keys = [
            "your ssh public key"
          ];
        };

        #TODO change hostname to your hostname
        networking.hostName = "hostname";
        networking.wireless.enable = false;
        networking.networkmanager.enable = true;
        networking.firewall.enable = true;

        #TODO change ssid to your network nmconnection filename
        environment.etc."NetworkManager/system-connections/ssid.nmconnection" = {
          source = ./ssid.nmconnection;
          mode = "0600";
          user = "root";
          group = "root";
        };

        #TODO disable openssh if not needed
        services.openssh.enable = true;
        services.openssh.settings.PasswordAuthentication = false;
        services.openssh.PermitRootLogin = "no";
      };
    in {
      nixosConfigurations = {
        x86Iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config, modulesPath, ... }: {
              imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

              # special boot options for broadcom wireless card
              boot.kernelModules = [ "wl" ];
              boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
              boot.blacklistedKernelModules = [ "b43" "bcma" ];
            })
            sharedConfig
          ];
        };

        x86 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./platforms/x86.nix
            sharedConfig
          ];
        };

        piImage = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ({ modulesPath, ... }: {
              imports = [ (modulesPath + "/installer/sd-card/sd-image-aarch64.nix") ];
            })
            sharedConfig
          ];
        };

        pi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./platforms/pi.nix
            sharedConfig
          ];
        };
      };
    };
}

