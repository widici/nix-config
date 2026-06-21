{ config, username, ... }:

{
  programs.fish.enable = config.home-manager.users.${username}.programs.fish.enable;
}
