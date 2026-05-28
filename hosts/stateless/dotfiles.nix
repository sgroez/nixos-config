{ pkgs, lib, ... }: let
  username = "stateless";
  group = "users";

  repo = pkgs.fetchFromGitHub rec {
    name = "dotfiles-${rev}";
    owner = "sgroez";
    repo = "dotfiles";
    rev = "f2c3b094140d1d7f65046dcd189d95f456a76b93";
    sha256 = "sha256-trcJX9zYp+wLsbm3I+vGxsePIVeErK4SY+DNmhFSSZU=";
  };

  entries = builtins.readDir repo;
  names = builtins.filter
    (name: entries.${name} == "directory")
    (builtins.attrNames entries);
in
{
  # create .config and symlink dotfiles into it
  systemd.tmpfiles.rules = [
    "d /home/${username}/.config 0700 ${username} ${group} - -"
  ] ++ (builtins.map (name:
    "L+ /home/${username}/.config/${name} - - - - ${repo}/${name}"
  ) names);
}
