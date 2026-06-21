{ lib, config, ... }:

{
  options.cli.tldr.enable = lib.mkEnableOption "tldr (tealdeer)" // {
    default = true;
  };

  config = lib.mkIf config.cli.tldr.enable {
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };
  };
}
