{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.home.cli.tokei;
in
{
  options.modules.home.cli.tokei = {
    enable = mkEnableOption "tokei";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tokei
    ];

    modules.home.shells.extraAliases = {
      lc = "tokei";
      loc = "tokei";
    };
  };
}
