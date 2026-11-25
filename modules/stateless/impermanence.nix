{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.stateless.impermanence;
  inherit (lib)
    types
    mkOption
    mkEnableOption
    mkIf
    mkMerge
    ;

  permissionType = types.submodule {
    options = {
      mode = mkOption {
        type = types.str;
        default = "0755";
      };
      owner = mkOption {
        type = types.str;
        default = "root";
      };
      group = mkOption {
        type = types.str;
        default = "root";
      };
    };
  };

  persistType = types.submodule {
    options = {
      source = mkOption {
        type = types.path;
      };
      target = mkOption {
        type = types.path;
      };
      permissions = mkOption {
        type = permissionType;
      };
    };
  };

  ensureType = types.submodule {
    options = {
      path = mkOption {
        type = types.path;
      };
      permissions = mkOption {
        type = permissionType;
      };
    };
  };

  linkType = types.submodule {
    options = {
      source = mkOption {
        type = types.path;
      };
      target = mkOption {
        type = types.path;
      };
    };
  };

  #TODO filter duplicates in persists, ensures and links ??

  #TODO make sure directories exist with correct permissions
  persistList = builtins.map (persist: {
    "${persist.target}" = {
      device = "${persist.source}";
      fsType = "none";
      options = [ "bind" ];
    };
  }) cfg.persists;

  ensureList = builtins.map (
    ensure:
    "d ${ensure.path} ${ensure.permissions.mode} ${ensure.permissions.owner} ${ensure.permissions.group} - -"
  ) cfg.ensures;

  linkList = builtins.map (link: "L+ ${link.target} - - - - ${link.source}") cfg.links;
in
{
  options.stateless.impermanence = {
    enable = mkEnableOption "enable stateless impermanence";
    persists = mkOption {
      type = types.listOf persistType;
      default = [ ];
    };
    ensures = mkOption {
      type = types.listOf ensureType;
      default = [ ];
    };
    links = mkOption {
      type = types.listOf linkType;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    fileSystems = mkMerge persistList;
    systemd.tmpfiles.rules = ensureList ++ linkList;
  };
}
