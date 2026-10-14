{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    genAttrs
    mkMerge
    ;

  cfg = config.modules.home.editors.helix.keybinds;

  disableArrowKeys = genAttrs [ "up" "down" "left" "right" ] (_: "no_op");
  normalModeKeys = {
    f.j = "normal_mode";
  };
in
{
  options.modules.home.editors.helix.keybinds = {
    arrowKeys.enable = mkEnableOption "arrow keys in helix";
  };

  config = {
    programs.helix.settings.keys = mkMerge [
      (genAttrs [
        "select"
        "insert"
      ] (_: normalModeKeys))
      (mkIf (!cfg.arrowKeys.enable) (genAttrs [ "normal" "select" "insert" ] (_: disableArrowKeys)))
    ];
  };
}
