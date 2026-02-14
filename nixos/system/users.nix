{ config, lib, username, ... }:

{
  config = lib.mkIf config.system.initPkgs.enable {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      home = "/home/${username}";
    };
    
    security.sudo.enable = true;
  };
}
