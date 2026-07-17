{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    genAttrs
    ;

  cfg = config.modules.home.shells;

  commonAliases = {
    cls = "clear";
    c = "clear";
    hist = "history";
    h = "history";
    iso = "date --iso-8601=seconds";
  };

  shells = [ "fish" ];
in
{
  imports = [
    ./fish.nix
  ];

  options.modules.home.shells = {
    shell = mkOption {
      type = types.enum shells;
      default = "fish";
      description = "shell to enable";
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

  config.modules.home.shells = genAttrs shells (name: {
    enable = cfg.shell == name;
  }) // {
    mergedAliases = commonAliases // cfg.extraAliases;
  };
}
