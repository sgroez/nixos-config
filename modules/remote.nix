{
#TODO Add your ssh public key for ssh auth and set password after first boot using cmdline
  users.users.remote = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "password";
    openssh.authorizedKeys.keys = [
      "your ssh public key"
    ];
  };

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

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";
}
