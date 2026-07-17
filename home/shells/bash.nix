{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    optionalString
    ;

  cfg = config.modules.home.shells.bash;
in
{
  options.modules.home.shells.bash = {
    enable = mkEnableOption "bash";
  };

  config = mkIf cfg.enable {
    programs = {
      bash = {
        enable = true;
        shellAliases = config.modules.home.shells.mergedAliases;
        initExtra = optionalString (config.modules.home.shells.greeting != "") ''
          echo "${config.modules.home.shells.greeting}"
        '';
      };

      fzf.enableBashIntegration = true;
      zoxide.enableBashIntegration = true;
    };
  };
}
