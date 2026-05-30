# This file implements functions to reduce boilerplate code for persist actions like
# bind mounting or symlinking files.
{
  bindmount = source: target: {
    "${target}" = {
      device = "${source}";
      fsType = "none";
      options = [ "bind" ];
    };
  };

  symlink = source: target: "L+ ${target} - - - - ${source}";

  ensureDir =
    path: permission: username: usergroup:
    "d ${path} ${permission} ${username} ${usergroup} - -";
}
