let
  persist = "/nix/persist";
  username = "stateless";
  group = "users";
in
{
  fileSystems."/etc/nixos" = {
    device = "${persist}/etc/nixos";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/var/log" = {
    device = "${persist}/var/log";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/etc/machine-id" = {
    device = "${persist}/etc/machine-id";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/etc/NetworkManager/system-connections" = {
    device = "${persist}/etc/NetworkManager/system-connections";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/home/${username}/.gitconfig" = {
    device = "${persist}/${username}/.gitconfig";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/home/${username}/.ssh" = {
    device = "${persist}/${username}/.ssh";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/home/${username}/code" = {
    device = "${persist}/${username}/code";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/home/${username}/books" = {
    device = "${persist}/${username}/books";
    fsType = "none";
    options = [ "bind" ];
  };
}
