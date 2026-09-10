{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    ;

  cfg = config.modules.nixos.core.nix;
in
{
  options.modules.nixos.core.nix = {
    full.enable = mkEnableOption "nix gc & optimization (not cachix)";
    cachix.enable = mkEnableOption "pull from cachix cache";
  };

  config = mkMerge [
    (mkIf cfg.full.enable {
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
    })

    (mkIf cfg.cachix.enable {
      nix.settings = {
        substituters = [ "https://widici-nix-config.cachix.org" ];
        trusted-public-keys = [
          "widici-nix-config.cachix.org-1:o6GqkbyYXWFHk+0/ZY9QdAx7d3SR/0clbLNCaMwh0Ow="
        ];
      };
    })
  ];
}
