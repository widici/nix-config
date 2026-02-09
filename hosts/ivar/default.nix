{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/wsl.nix
    ../../nixos/users.nix
    ../../nixos/init-pkgs.nix
  ];

  networking.hostName = "ivar";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.widici = import ../../home;
  };

  system.stateVersion = "25.05";
}
