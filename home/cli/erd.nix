{ lib, config, pkgs, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.cli.erd;
in
{
  options.modules.home.cli.erd = {
    enable = mkEnableOption "erd";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      erdtree
    ];

    modules.home.shells.extraAliases = {
      tree = "erd";
    };
  };
}
