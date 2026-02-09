{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "widici";

  users.users = {
    widici = {
      isNormalUser = true;
      extraGroups = [ "wheel"];
    };
  };

  security.sudo.enable = true;

  environment.systemPackages = with pkgs; [
    git curl wget helix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # TODO: move this
  programs.git = {
    enable = true;
    config = {
      user.name = "widici";
      user.email = "84205124+widici@users.noreply.github.com";
    };
  };
  
  system.stateVersion = "25.05";
}
