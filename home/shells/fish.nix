{ lib, config, ... }:

{
  options.shells.fish.enable = lib.mkEnableOption "fish shell" // {
    default = true;
  };

  config = lib.mkIf config.shells.fish.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting ""
      '';

      shellAliases = {
        cls = "clear";
        c = "clear";
      };
    };
  }; 
}
