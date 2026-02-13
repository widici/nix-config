{ config, pkgs, ... }:

{
  system.wsl.enable = true;

  networking.hostName = "ivar";
}
