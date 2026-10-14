{
  lib,
  config,
  vars,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.nixos.cli.nh;
in
{
  options.modules.nixos.cli.nh = {
    enable = mkEnableOption "nh (yet-another-nix-helper)";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = vars.path;
    };
  };
}
