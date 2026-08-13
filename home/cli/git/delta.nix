{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.home.cli.git.delta;
in
{
  options.modules.home.cli.git.delta = {
    enable = mkEnableOption "git delta";
  };

  config = mkIf cfg.enable {
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
