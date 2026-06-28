# TODO: option for enabling --icons when using a nerd font

{ lib, config, pkgs, ... }:

{
  options.cli.erd.enable = lib.mkEnableOption "erd" // {
    default = true;
  };

  config = lib.mkIf config.cli.erd.enable {
    home.packages = with pkgs; [
      erdtree
    ];

    programs.fish.shellAliases = lib.mkIf config.shells.fish.enable {
      tree = "erd";
    };
  };
}
