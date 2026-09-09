{
  lib,
  config,
  inputs,
  vars,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.nixos.core.hm;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.modules.nixos.core.hm = {
    enable = mkEnableOption "home manager";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs vars; };
      users.${vars.username} = import ../../home;
    };
  };
}
