{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.stateless.persist;
  inherit (lib)
    types
    mkOption
    mkEnableOption
    mkIf
    mkMerge
    ;

  mappingType = types.submodule {
    options = {
      source = mkOption {
        type = types.path;
      };
      target = mkOption {
        type = types.path;
      };
    };
  };

  ensureType = types.submodule {
    options = {
      path = mkOption {
        type = types.path;
      };
      permission = mkOption {
        type = types.str;
      };
      username = mkOption {
        type = types.str;
      };
      usergroup = mkOption {
        type = types.str;
      };
    };
  };
in
{
  options.stateless.persist = {
    enable = mkEnableOption "stateless persist";
    binds = mkOption {
      type = types.listOf mappingType;
      default = [ ];
    };
    links = mkOption {
      type = types.listOf mappingType;
      default = [ ];
    };
    ensures = mkOption {
      type = types.listOf ensureType;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    fileSystems = mkMerge (builtins.map (bind: (myLib.persist.bindmount bind.source bind.target)) cfg.binds);

    systemd.tmpfiles.rules = (builtins.map (link: (myLib.persist.symlink link.source link.target)) cfg.links)
      ++ (builtins.map (
        ensure: (myLib.persist.ensureDir ensure.path ensure.permission ensure.username ensure.usergroup)
      ) cfg.ensures);
  };
}
