{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.cli.bat;
in
{
  options.modules.home.cli.bat = {
    enable = mkEnableOption "bat";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
    };

    modules.home.shells.extraAliases = {
      cat = "bat";
    };
  };
}
