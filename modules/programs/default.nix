{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  inherit (lib)
    map
    attrNames
    ;

  usernames = lib.pipe config.users.users [
    (lib.filterAttrs (name: userConfig: userConfig.isNormalUser))
    lib.attrNames
  ];
in
{
  imports = [
    ./hyprland.nix
    ./neovim.nix
    ./fuzzel.nix
    ./firefox.nix
  ];
  # make sure .config folder exists with right permissions in user directory
  systemd.tmpfiles.rules = map (
    username: myLib.persist.ensureDir "/home/${username}/.config" "700" username "users"
  ) usernames;
}
