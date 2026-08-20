{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    genAttrs
    ;

  cfg = config.modules.home.editors.helix;

  disableArrowKeys = genAttrs [ "up" "down" "left" "right" ] (_: "no_op");
  normalModeKeys = {
    f.j = "normal_mode";
  };
in
{
  imports = [
    ./languages
  ];

  options.modules.home.editors.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;

      settings = {
        editor = {
          shell = [
            config.modules.home.shells.defaultShell
            "-c"
          ];

          line-number = "relative";
          bufferline = "multiple";
          true-color = true;
          auto-format = true;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          soft-wrap.enable = true;
        };

        keys = {
          normal = disableArrowKeys;
          select = normalModeKeys // disableArrowKeys;
          insert = normalModeKeys // disableArrowKeys;
        };
      };
    };
  };
}
