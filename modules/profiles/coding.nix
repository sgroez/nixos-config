{ pkgs, ... }:
let
  cfg = config.profiles.coding;
in
{
  options.profiles.coding = {
    enable = lib.mkEnableOption "coding profile";
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
