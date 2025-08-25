{
  imports = [
    ../../modules/remote.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # special boot options for broadcom wireless card
  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  boot.blacklistedKernelModules = [ "b43" "bcma" ];

  networking.hostName = "xeondesktop";
}
