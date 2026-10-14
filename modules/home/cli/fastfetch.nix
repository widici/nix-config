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

  cfg = config.modules.home.cli.fastfetch;
in
{
  options.modules.home.cli.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        logo = {
          source = "nixos_old_small";
          padding = {
            top = 1;
            bottom = 1;
          };
        };

        modules = [
          "break"
          "title"
          "separator"
          "os"
          "kernel"
          "uptime"
          "shell"
          "memory"
          "break"
        ];
      };
    };

    modules.home.shells.extraAliases = {
      ff = "fastfetch";
    };
  };
}
