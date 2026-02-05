{ pkgs, ... }: {
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
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.firewall.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # FONTS
  fonts.packages = with pkgs; [
    jetbrains-mono
    material-symbols
  ];

  # PACKAGES
  environment.systemPackages = with pkgs; [
    git
    gh
    stow
    neovim
    tealdeer
    cmus
    lynx
  ];

  # EXTRA FEATURES / SERVICES
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.direnv.enable = true;

}
