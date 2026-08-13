{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.home.cli.git.gh;
in
{
  options.modules.home.cli.git.gh = {
    enable = mkEnableOption "github cli";
  };

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
