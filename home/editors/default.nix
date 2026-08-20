{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    genAttrs
    ;

  cfg = config.modules.home.editors;

  availableEditors = [
    "helix"
  ];
in
{
  imports = [
    ./helix
  ];

  options.modules.home.editors = {
    enable = mkEnableOption "editor(s) support";

    defaultEditor = mkOption {
      type = types.enum availableEditors;
      default = "helix";
      description = "the default editor";
    };

    enabledEditors = mkOption {
      type = types.listOf (types.enum availableEditors);
      default = [ cfg.defaultEditor ];
      description = "editors to enable";
    };

    tooling = {
      nix.enable = mkEnableOption "nix editor tooling";
    };
  };

  config = mkIf cfg.enable {
    modules.home.editors = genAttrs availableEditors (name: {
      enable = builtins.elem name cfg.enabledEditors;
    });
  };
}
