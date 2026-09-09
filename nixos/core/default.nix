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
    ./wsl.nix
  ];

  options.modules.nixos.core = {
    full.enable = mkEnableOption "core functionalities (e.g. users & locale), not wsl";
  };

  config = mkIf cfg.full.enable {
    modules.nixos.core = {
      hm.enable = true;
      nix.enable = true;
      users.enable = true;
      locale.enable = true;
    };
  };
}
