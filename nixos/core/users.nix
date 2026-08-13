# TODO: enable shells based on home shell config

{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

{
  options.core.users.enable = lib.mkEnableOption "user creation and sudo access" // {
    default = true;
  };

  config = lib.mkIf config.core.users.enable {
    users.users.${vars.username} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      home = "/home/${vars.username}";
      shell = pkgs.fish;
    };

    programs.fish.enable = true;

    security.sudo.enable = true;
  };
}
