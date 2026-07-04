{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    mkMerge
    ;

  cfg = config.modules.home.cli;
in
{
  imports = [
    ./bat.nix
    ./erd.nix
    ./fzf.nix
    ./git
    ./tldr.nix
    ./tokei.nix
    ./zoxide.nix
  ];

  options.modules.home.cli = {
    oxidisation.enable = mkEnableOption "rust replacements for common cli tools";
  };

  config = mkMerge [
    (mkIf cfg.oxidisation.enable {
      modules.home.cli = {
        bat.enable = true;
        erd.enable = true;
        fzf.enable = true;
        tldr.enable = true;
        tokei.enable = true;
        zoxide.enable = true;
      };
    })
  ];
}
