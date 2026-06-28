{ lib, config, ... }:

{
  options.cli.zoxide.enable = lib.mkEnableOption "zoxide" // {
    default = true;
  };

  config = lib.mkIf config.cli.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = config.shells.fish.enable;
      options = [ "--cmd cd" ];
    };
  };
}
