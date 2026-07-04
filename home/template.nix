{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.category.name;
in
{
  options.modules.home.category.name = {
    enable = mkEnableOption "name";

    greeting = mkOption {
      type = types.str;
      default = "hello world!";
      description = "a friendly greeting";
    };
  };

  config = mkIf cfg.enable {
    programs.name = {
      enable = true;
    };

    home.packages = with pkgs; [
      name
    ];

    home.sessionVariables.GREET = cfg.greeting; 
  };
}
