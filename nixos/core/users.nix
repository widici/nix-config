# TODO: enable shells based on home shell config

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
      shell = pkgs.fish;
    };

    programs.fish.enable = true;
    
    security.sudo.enable = true;
  };
}
