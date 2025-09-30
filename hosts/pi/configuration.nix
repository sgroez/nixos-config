{

  imports = [
    ../../modules/base.nix
    ../../modules/extra/powermanagement.nix
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = false; # Not needed on ARM either
  boot.loader.generic-extlinux-compatible.enable = true;


  #TODO Add your ssh public key for ssh auth and set password after first boot using cmdline
  users.users.pi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "password";
    openssh.authorizedKeys.keys = [
      "your ssh public key"
    ];
  };

  networking.hostName = "pi";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  environment.etc."NetworkManager/system-connections/ssid.nmconnection" = {
    source = ~/Documents/ssid.nmconnection;
    mode = "0600";
    user = "root";
    group = "root";
  };

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;

  system.stateVersion = "25.05";
}
