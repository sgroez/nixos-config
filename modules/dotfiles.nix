{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.dotfiles;
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    mkMerge
    concatMap
    ;

  repo = pkgs.fetchFromGitHub rec {
    name = "dotfiles-${rev}";
    owner = "sgroez";
    repo = "dotfiles";
    rev = "f2c3b094140d1d7f65046dcd189d95f456a76b93";
    sha256 = "sha256-trcJX9zYp+wLsbm3I+vGxsePIVeErK4SY+DNmhFSSZU=";
  };

  contentsSet = builtins.readDir repo;
  contents = builtins.map (name: {
    inherit name;
    type = contentsSet.${name};
  }) (builtins.attrNames contentsSet);
  entries = builtins.filter (entry: entry.type == "directory") contents;
in
{
  options.dotfiles = {
    enable = mkEnableOption "dotfiles";
    usernames = mkOption {
      type = types.listOf types.str;
    };
    usergroup = mkOption {
      type = types.str;
    };
  };

  # make sure .config exists for user and has the right permissions
  # symlink dotfiles into home directories of users
  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = (
      concatMap (
        username:
        [
          (myLib.persist.ensureDir "/home/${username}/.config" "700" username cfg.usergroup)
        ]
        ++ (builtins.map (
          entry: myLib.persist.symlink "${repo}/${entry.name}" "/home/${username}/.config/${entry.name}"
        ) entries)
      ) cfg.usernames
    );
  };
}
