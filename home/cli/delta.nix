{ lib, config, ... }:

{
  options.cli.delta.enable = lib.mkEnableOption "git delta" // {
    default = true;
  };

  config = lib.mkIf config.cli.delta.enable {
    assertions = [
      {
        assertion = config.cli.git.enable;
        message = "cli.delta requires cli.git to be enabled";
      }
    ];

    programs.git.delta = {
      enable = true;

      options = {
        navigate = true;
        dark = true;  
      };
    };
  };
}
