{ lib, config, ... }:

{
  options.cli.ssh.enable = lib.mkEnableOption "ssh" // {
    default = true;
  };

  config = lib.mkIf config.cli.ssh.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
           addKeysToAgent = "yes";
        };
        
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
          identitiesOnly = true;
        };
      };
    };

    services.ssh-agent = {
      enable = true;
    };
  };
}
