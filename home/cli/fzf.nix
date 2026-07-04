{lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.cli.fzf;
in
{
  options.modules.home.cli.fzf = {
    enable = mkEnableOption "fzf";
  }; 

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.shells.fish.enable;
    };
  };
}
