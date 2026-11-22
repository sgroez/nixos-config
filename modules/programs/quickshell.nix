
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.quickshell;
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    concatMap
    ;

  usernames = lib.pipe config.users.users [
    (lib.filterAttrs (name: userConfig: userConfig.isNormalUser))
    lib.attrNames
  ];
in
{
  options.quickshell = {
    enable = mkEnableOption "enable quickshell";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickshell
    ];
    # symlink config file to user home dir
    systemd.tmpfiles.rules = concatMap (username: [
      (myLib.persist.symlink "${./quickshell}" "/home/${username}/.config/quickshell")
    ]) usernames;
  };
}
