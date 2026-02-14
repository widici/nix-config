{ config, pkgs, ... }:

{
  system.wsl.enable = true;

  networking.hostName = "ivar";

  system.stateVersion = "25.05";
}
