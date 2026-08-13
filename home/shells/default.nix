{ lib, config, ... }:

let
  inherit (lib)
    mkOption
    types
    genAttrs
    ;

  cfg = config.modules.home.shells;

  commonAliases = {
    cls = "clear";
    c = "clear";
    hist = "history";
    h = "history";
    iso = "date --iso-8601=date";
  };

  availableShells = [
    "fish"
    "bash"
  ];
in
{
  imports = [
    ./fish.nix
    ./bash.nix
    ./starship.nix
  ];

  options.modules.home.shells = {
    defaultShell = mkOption {
      type = types.enum availableShells;
      default = "fish";
      description = "the default shell";
    };

    enabledShells = mkOption {
      type = types.listOf (types.enum availableShells);
      default = [ cfg.defaultShell ];
      description = "shells to enable";
    };

    extraAliases = mkOption {
      type = types.attrsOf types.str;
      default = { };
      description = "extra shell aliases";
    };

    mergedAliases = mkOption {
      type = types.attrsOf types.str;
      readOnly = true;
      description = "merged shell aliases (common and extra aliases)";
    };

    greeting = mkOption {
      type = types.str;
      default = "";
      description = "shell greeting";
    };
  };

  config.modules.home.shells =
    genAttrs availableShells (name: {
      enable = builtins.elem name cfg.enabledShells;
    })
    // {
      mergedAliases = commonAliases // cfg.extraAliases;
    };
}
