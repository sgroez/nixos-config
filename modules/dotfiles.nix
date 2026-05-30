{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.dotfiles;

  repo = pkgs.fetchFromGitHub rec {
    name = "dotfiles-${rev}";
    owner = "sgroez";
    repo = "dotfiles";
    rev = "f2c3b094140d1d7f65046dcd189d95f456a76b93";
    sha256 = "sha256-trcJX9zYp+wLsbm3I+vGxsePIVeErK4SY+DNmhFSSZU=";
  };

  entries = builtins.filter (entry: entries.${entry} == "directory") (
    builtins.attrNames (builtins.readDir repo)
  );
in
{
  options.dotfiles = {
    enable = lib.mkEnableOption "dotfiles";
    usernames = lib.mkOption {
      type = types.listOf str;
    };
    usergroup = lib.mkOption {
      type = types.str;
    };
  };

  # make sure .config exists for user and has the right permissions
  # symlink dotfiles into home directories of users
  config = mkIf cfg.enable (
    lib.mkMerge (
      lib.concatMap (
        username:
        [
          (myLib.ensureDir "/home/${username}/.config" "700" username cfg.usergroup)
        ]
        ++ (builtins.map (
          entry: myLib.symlink "${repo}/${entry}" "/home/${username}/.config/${entry}"
        ) entries)
      ) cfg.usernames
    )
  );
}
