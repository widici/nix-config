{ config, pkgs, username, ... }:

{
  imports = [
    ../../nixos/profiles/wsl.nix
  ];
  
  networking.hostName = "ivar";
  system.stateVersion = "25.05";

  home-manager.users.${username} = {
    imports = [
      ../../home/profiles/dev.nix
    ];
    
    modules.home = {
      cli.git.signing = {
        enable = true;
        key = "~/.ssh/id_ed25519.pub";
      };

      shells = {
        defaultShell = "fish";
        enabledShells = [ "fish" "bash" ];
        starship.enable = true;
      };
    };
  };
}
