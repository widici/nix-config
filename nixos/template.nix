{
  config,
  lib,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.nixos.category.name;
in
{
  options.modules.nixos.category.name = {
    enable = mkEnableOption "name";

    animal = mkOption {
      type = types.str;
      default = "mallard";
      description = "a friendly animal";
    };
  };

  config = mkIf cfg.enable {
    # ...
  };
}
