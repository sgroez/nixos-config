{ pkgs, ... }: {
  users.users.sim = {
    isNormalUser = true;
    description = "sim";
    initialPassword = "password";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
