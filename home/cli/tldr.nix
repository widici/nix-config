{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.cli.tldr;
in
{
  options.modules.home.cli.tldr = {
    enable = mkEnableOption "tldr (tealdeer)";
  };

  config = mkIf cfg.enable {
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };
  };
}
