{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.kitty;
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

  configFile = pkgs.writeText "kitty.conf" ''
    confirm_os_window_close 0
    font_family Unifont
    bold_font auto
    italic_font auto
    bold_italic_font auto
    font_size 15.0
    modify_font cell_width 60%
  '';
in
{
  options.kitty = {
    enable = mkEnableOption "enable kitty";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
    # symlink config file to user home dir
    systemd.tmpfiles.rules = concatMap (username: [
      (myLib.persist.ensureDir "/home/${username}/.config/kitty" "0700" username "users")
      (myLib.persist.symlink "${configFile}" "/home/${username}/.config/kitty/kitty.conf")
    ]) usernames;
  };
}
