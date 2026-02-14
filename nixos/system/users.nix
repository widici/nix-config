{ config, lib, username, ... }:

{
  options.system.users.enable = lib.mkEnableOption "user creation and sudo access" // {
    default = true;
  };
  
  config = lib.mkIf config.system.users.enable {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      home = "/home/${username}";
    };
    
    security.sudo.enable = true;
  };
}
