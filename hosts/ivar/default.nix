{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/system
  ];

  system.wsl.enable = true;

  networking.hostName = "ivar";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.widici = import ../../home;
  };

  system.stateVersion = "25.05";
}
