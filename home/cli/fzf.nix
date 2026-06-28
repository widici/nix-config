{lib, config, ... }:

{
  options.cli.fzf.enable = lib.mkEnableOption "fzf" // {
    default = true;
  };

  config = lib.mkIf config.cli.fzf.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.shells.fish.enable;
    };
  };
}
