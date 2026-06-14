{ lib, config, ... }:

{
  options.shell.fish.enable = lib.mkEnableOption "fish shell" // {
    default = true;
  };

  config = lib.mkIf config.shell.fish.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting ""
      '';

      shellAliases = {
        cls = "clear";
      };
    };
  }; 
}
