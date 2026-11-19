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

  usernames = attrNames config.users.users;
in
{
  # make sure .config folder exists with right permissions in user directory
  systemd.tmpfiles.rules = map (
    username: myLib.persist.ensureDir "/home/${username}/.config" "700" username "users"
  ) usernames;
}
