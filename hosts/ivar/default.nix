{ config, pkgs, username, ... }:

{
  imports = [
    ../../nixos/profiles/wsl.nix
  ];

  networking.hostName = "ivar";

  system.stateVersion = "25.05";

  home-manager.users.${username} = {
    modules.home.cli.git = {
      enable = true;

      signing = {
        enable = true;
        key = "~/.ssh/id_ed25519.pub";
      };

      gh.enable = true;
      delta.enable = true;
    };
  };
}
