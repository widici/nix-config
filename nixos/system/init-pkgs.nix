{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.system.initPkgs.enable {
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
      helix
    ];
  };
}
