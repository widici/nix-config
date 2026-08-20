{
  lib,
  config,
  ...
}:

let
  inherit (lib)
    mkIf
    ;

  cfg = config.modules.home.editors;
in
{
  config = mkIf (cfg.tooling.nix.enable && cfg.helix.enable) {
    programs.helix.languages.language = [
      {
        name = "nix";
        language-servers = [ "nixd" ];
        formatter = {
          command = "treefmt";
          args = [
            "-q"
            "--stdin"
            "file.nix"
          ];
        };
      }
    ];
  };
}
