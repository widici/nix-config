{ lib, config, ... }:

{
  options.cli.bat.enable = lib.mkEnableOption "bat" // {
    default = true;
  };

  config = lib.mkIf config.cli.bat.enable {
    programs.bat = {
      enable = true;
    };

    programs.fish.shellAliases = lib.mkIf config.shell.fish.enable {
      cat = "bat";
    };
  };
}
