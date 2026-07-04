{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.cli.zoxide;
in
{
  options.modules.home.cli.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.shells.fish.enable;
      options = [ "--cmd cd" ];
    };
  };
}
