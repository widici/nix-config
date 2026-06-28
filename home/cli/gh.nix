# TODO: use a secret for auth keys?

{ lib, config, ... }:

{
  options.cli.gh.enable = lib.mkEnableOption "github cli" // {
    default = true;
  };

  config = lib.mkIf config.cli.gh.enable {
    assertions = [
      {
        assertion = config.cli.ssh.enable;
        message = "cli.gh requires cli.ssh to be enabled";
      }
    ];
    
    programs.gh = {
      enable = true;

      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
  };
}
