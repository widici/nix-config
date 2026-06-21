{ config, lib, pkgs, username, ... }:

{
  options.core.users.enable = lib.mkEnableOption "user creation and sudo access" // {
    default = true;
  };
  
  config = lib.mkIf config.core.users.enable {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      home = "/home/${username}";
      shell = if config.programs.fish.enable then pkgs.fish else pkgs.bash;
    };
    
    security.sudo.enable = true;
  };
}
