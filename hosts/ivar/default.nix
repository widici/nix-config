{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/profiles/wsl.nix
  ];

  networking.hostName = "ivar";

  system.stateVersion = "25.05";
}
