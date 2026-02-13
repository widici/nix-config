{ config, lib, ... }:

{
  config = lib.mkIf config.system.initPkgs.enable {
    users.users.widici = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      home = "/home/widici";
    };
    
    security.sudo.enable = true;
  };
}
