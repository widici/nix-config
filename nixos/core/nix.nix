{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.nixos.core.nix;
in
{
  options.modules.nixos.core.nix = {
    enable = mkEnableOption "nix";
  };

  config = mkIf cfg.enable {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
        randomizedDelaySec = "15min";
      };

      optimise = {
        automatic = true;
        randomizedDelaySec = "15min";
      };
    };
  };
}
