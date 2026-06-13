{ config, lib, username, ... }:

{
  imports = [
    ./wsl.nix
    ./users.nix
  ];

  programs.fish.enable = config.home-manager.users.${username}.programs.fish.enable;
}
