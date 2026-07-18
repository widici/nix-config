{ lib, config,... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
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
  options.modules.home.editors.helix = {
    enable = mkEnableOption "helix";

    defaultEditor = mkOption {
      type = types.bool;
      default = true;
      description = "helix as the default editor";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = cfg.defaultEditor;

      settings = {
        theme = "catppuccin_mocha";

        editor = {
          shell = [ config.modules.home.shells.defaultShell "-c" ];
          
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
