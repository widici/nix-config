{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.nixos.core;
in
{
  imports = [
    ./hm.nix
    ./locale.nix
    ./nix.nix
    ./users.nix
  ];

  options.modules.nixos.core = {
    enable = mkEnableOption "core functionalities (e.g. users)";
  };

  config = mkIf cfg.enable {
    modules.nixos.core = {
      hm.enable = true;
      nix.enable = true;
      users.enable = true;
      locale.enable = true;
    };
  };
}
