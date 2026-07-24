{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.home.styling.stylix;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.modules.home.styling.stylix = {
    enable = mkEnableOption "stylix";

    scheme = mkOption {
      type = types.str;
      default = "catppuccin-mocha";
      description = "the system-wide color scheme (choose from https://github.com/tinted-theming/schemes/tree/spec-0.11/base16)";
    };

    headless = mkOption {
      type = types.bool;
      default = false;
      description = "disables styling for common gui targets";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/${cfg.scheme}.yaml";

      targets = mkIf cfg.headless {
        gtk.enable = false;
        qt.enable = false;
        gnome.enable = false;
        eog.enable = false;
        gnome-text-editor.enable = false;
      };
    };
  };
}
