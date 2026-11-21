{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.fuzzel;
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

  configFile = pkgs.writeText "fuzzel.ini" ''
    [main]
    font=Unifont:weight=regular:size=20
    [colors]
    background=000000ff
    text=faba38ff
    match=ffee4fff
    selection-match=ffee4fff
    selection=a06419ff
    selection-text=faba38ff
    border=ffee4fff;
  ''
in
{
  options.fuzzel = {
    enable = mkEnableOption "enable fuzzel";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fuzzel
    ];
    # symlink config file to user home dir
    systemd.tmpfiles.rules = concatMap (username: [
      (myLib.persist.ensureDir "/home/${username}/.config/fuzzel" "0700" username "users")
      (myLib.persist.symlink "${configFile}" "/home/${username}/.config/fuzzel/fuzzel.ini")
    ]) usernames;
  };
}
