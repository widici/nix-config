{
  lib,
  config,
  pkgs,
  vars,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.nixos.core.users;
in
{
  options.modules.nixos.core.users = {
    enable = mkEnableOption "users";
  };

  config = mkIf cfg.enable {
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
