# Impermanence module draft and documentation

## Requirements
- handle filesystem mounting from persistent storage (persistPath, list of individual subpaths, permissions, ownership)
- handle intermediary directories that need to exists for a functioning system (paths, permissions, ownership)
- handle symlinking files or directories from nix store (source, target)

## Draft for configuration api

persistType = {
    source = path;
    target = path;
    permissions = string;
    owner = string;
    group = string;
}

ensureType = {
    path = path;
    permissions = string;
    owner = string;
    group = string;
}

linkType = {
    source = path;
    target = path;
}

options = {
    persists = list of persistType;
    ensures = list of ensureType;
    links = list of linkType;
}

## Draft for computing filesystem and systemd tmpfile rule options
- loop over all persist, ensure and link items

### persist function
- make sure persist path exists with correct permissions
- bind mount to right location

### ensure function
- make sure path exists with correct permissions

### symlink function
- symlink file or directory to target (ignore permissions because files are readonly in nix store
