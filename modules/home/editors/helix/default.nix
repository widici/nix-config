{ lib, config, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.modules.home.editors.helix;
in
{
  imports = [
    ./languages.nix
    ./keybinds.nix
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

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          soft-wrap.enable = true;

          file-picker.hidden = false;
        };
      };
    };
  };
}
