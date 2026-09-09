{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.modules.nixos.core.locale;
in
{
  options.modules.nixos.core.locale = {
    enable = mkEnableOption "locale";

    language = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "locale identifier (language_TERRITORY.codeset) for language";
    };

    format = mkOption {
      type = types.str;
      default = "en_GB.UTF-8";
      description = "locale identifier (language_TERRITORY.codeset) for formatting units, dates, paper, etc.";
    };

    timeZone = mkOption {
      type = types.str;
      default = "Europe/Stockholm";
      description = "time zone (Continent/City)";
    };

    keyMap = mkOption {
      type = types.str;
      default = "sv-latin1";
      description = "console keymap";
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;

    i18n = {
      defaultLocale = cfg.language;

      extraLocaleSettings = {
        LC_ADDRESS = cfg.format;
        LC_IDENTIFICATION = cfg.format;
        LC_MEASUREMENT = cfg.format;
        LC_MONETARY = cfg.format;
        LC_NAME = cfg.format;
        LC_NUMERIC = cfg.format;
        LC_PAPER = cfg.format;
        LC_TELEPHONE = cfg.format;
        LC_TIME = cfg.format;
      };
    };

    console = {
      inherit (cfg) keyMap;
    };
  };
}
