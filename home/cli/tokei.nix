{ lib, config, pkgs, ... }:

{
  options.cli.tokei.enable = lib.mkEnableOption "tokei" // {
    default = true;
  };

  config = lib.mkIf config.cli.tokei.enable {
    home.packages = with pkgs; [
      tokei
    ];

    programs.fish.shellAliases = lib.mkIf config.shells.fish.enable {
      lc = "tokei";
      loc = "tokei";
    };
  };
}
