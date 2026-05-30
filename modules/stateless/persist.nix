{
  pkgs,
  lib,
  config,
  myLib,
  ...
}:
let
  cfg = config.stateless.persist;

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
    enable = lib.mkEnableOption "stateless persist";
    binds = lib.mkOption {
      type = types.listOf mappingType;
      default = [ ];
    };
    links = lib.mkOption {
      type = types.listOf mappingType;
      default = [ ];
    };
    ensures = lib.mkOption {
      type = types.listOf ensureType;
      default = [ ];
    };
  };

  config = mkIf cfg.enable (
    lib.mkMerge (builtins.map (bind: (myLib.bindmount bind.source bind.target)) binds)
    ++ (builtins.map (link: (myLib.symlink link.source link.target)) links)
    ++ (builtins.map (
      ensure: (myLib.ensureDir ensure.path ensure.permission ensure.username ensure.usergroup)
    ) ensures)
  );
}
