{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.home.shells.fish;
in
{
  options.modules.home.shells.fish = {
    enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;
        shellAliases = config.modules.home.shells.mergedAliases;
        interactiveShellInit = ''
          set fish_greeting "${config.modules.home.shells.greeting}"
        '';
      };

      fzf.enableFishIntegration = true;
      zoxide.enableFishIntegration = true;
    };
  };
}
