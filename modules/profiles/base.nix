{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.base;
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;
in
{
  options.profiles.base = {
    enable = mkEnableOption "base profile";
    hostname = mkOption {
      type = types.str;
      default = "hostname";
    };
  };

  config = mkIf cfg.enable {
    # BOOT
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # LOCALES
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

    # NETWORK
    services.resolved.enable = true;
    networking = {
      hostName = "${cfg.hostname}";
      networkmanager.enable = true;
      firewall = {
        enable = true;
        # allowedTCPPorts = [ 22 ];
        # allowedUDPPorts = [ ... ];
      };
    };

    # FONTS
    fonts.packages = with pkgs; [
      jetbrains-mono
      material-symbols
      unifont
    ];

    # PACKAGES
    environment.systemPackages = with pkgs; [
      stow
      tealdeer
      cmus
    ];
    git.enable = true;
    neovim.enable = true;

    # EXTRA FEATURES / SERVICES
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    programs.direnv.enable = true;
  };
}
