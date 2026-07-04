{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.cli.git.delta;
in
{
  options.modules.home.cli.git.delta = {
    enable = lib.mkEnableOption "git delta";
  };

  config = lib.mkIf cfg.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;

      options = {
        navigate = true;
        dark = true;  
      };
    };
  };
}
