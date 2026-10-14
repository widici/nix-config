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

  cfg = config.modules.nixos.core.wsl;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  options.modules.nixos.core.wsl = {
    enable = mkEnableOption "wsl";
  };

  config = mkIf cfg.enable {
    wsl = {
      enable = true;
      defaultUser = vars.username;
    };
  };
}
