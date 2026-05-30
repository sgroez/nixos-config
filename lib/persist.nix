# This file implements functions to reduce boilerplate code for persist actions like
# bind mounting or symlinking files.
self: {
  bindmount = source: target: {
    fileSystems."${target}" = {
      device = "${source}";
      fsType = "none";
      options = [ "bind" ];
    };
  };

  symlink = source: target: {
    systemd.tmpfiles.rules = [
      "L+ ${target} - - - - ${source}"
    ];
  };

  ensureDir = path: permission: username: usergroup: {
    systemd.tmpfiles.rules = [
      "d ${path} ${permission} ${username} ${usergroup} - -"
    ];
  };
}
