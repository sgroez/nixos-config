{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.base;
in
{
  options.profiles.base = {
    enable = lib.mkEnableOption "base profile";
    hostname = lib.mkOption {
      type = types.str;
      default = "hostname";
    };
  };

  config = mkIf cfg.enable {
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
    ];

    # PACKAGES
    environment.systemPackages = with pkgs; [
      git
      stow
      neovim
      tealdeer
      cmus
    ];

    # EXTRA FEATURES / SERVICES
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    programs.direnv.enable = true;
  };
}
