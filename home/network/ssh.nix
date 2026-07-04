{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.network.ssh;
in
{
  options.modules.home.network.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
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
