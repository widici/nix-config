{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    ;

  cfg = config.modules.home.cli;
in
{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./erd.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git
    ./tldr.nix
    ./tokei.nix
    ./zoxide.nix
  ];

  options.modules.home.cli = {
    oxidization.enable = mkEnableOption "rust replacements for common cli tools";
    dev.enable = mkEnableOption "common cli tools used for development";
    fun.enable = mkEnableOption "fun cli tools (e.g. fastfetch)";
  };

  config = mkMerge [
    (mkIf cfg.oxidization.enable {
      modules.home.cli = {
        bat.enable = true;
        erd.enable = true;
        fzf.enable = true;
        tldr.enable = true;
        tokei.enable = true;
        zoxide.enable = true;
      };
    })

    (mkIf cfg.dev.enable {
      modules.home.cli = {
        git.full.enable = true;
        direnv.enable = true;
      };
    })

    (mkIf cfg.fun.enable {
      modules.home.cli = {
        fastfetch.enable = true;
      };
    })
  ];
}
