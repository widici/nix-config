{ lib, config, username, email, ... }:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    mkMerge
    ;

  cfg = config.modules.home.cli.git;
in
{
  imports = [
    ./delta.nix
    ./gh.nix
  ];
  
  options.modules.home.cli.git = {
    enable = mkEnableOption "git";

    full.enable = mkEnableOption "git and related cli tools, not git signing";

    username = mkOption {
      type = types.str;
      default = username;
      description = "git user.name";
    };

    email = mkOption {
      type = types.str;
      default = email;
      description = "git user.email";
    };

    signing = {
      enable = mkEnableOption "sign git commits";

      format = mkOption {
        type = types.enum [
          "openpgp"
          "ssh"
        ];
        default = "ssh";
        description = "git signing format";
      };

      key = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "git signing key";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.full.enable {
      modules.home.cli.git = {
        enable = true;
        delta.enable = true;
        gh.enable = true;
      };
    })

    (mkIf cfg.enable {
      programs.git = {
        enable = true;
        
        signing = mkIf cfg.signing.enable {
          inherit (cfg.signing) format;
          inherit (cfg.signing) key;
          signByDefault = true;
        };

        settings = {
          user.name = cfg.username;
          user.email = cfg.email;

          init.defaultBranch = "master";
          pull.rebase = false;
          push.autoSetupRemote = true;

          alias = {
            st = "status";
            pu = "push";
            puf = "push --force";
            co = "checkout";
            br = "branch";
            cm = "commit -m";
            cam = "commit -am";
          };
        };
      };
    })
  ];
}
