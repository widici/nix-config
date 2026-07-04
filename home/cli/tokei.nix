{ lib, config, pkgs, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
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

    programs.fish.shellAliases = mkIf config.shells.fish.enable {
      lc = "tokei";
      loc = "tokei";
    };
  };
}
