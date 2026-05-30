{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.profiles.coding;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.coding = {
    enable = mkEnableOption "coding profile";
  };

  config = mkIf cfg.enable {
    profiles.gui.enable = true;
    virtualisation.podman.enable = true;

    environment.systemPackages = with pkgs; [
      arduino-ide
      podman-compose
    ];
  };
}
