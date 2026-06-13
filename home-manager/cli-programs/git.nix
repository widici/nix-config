{ lib, config, username, email, ... }:
{
  options.cliPrograms.git.enable = lib.mkEnableOption "Enable git" // {
    default = true;
  };

  config = lib.mkIf config.cliPrograms.git.enable {
    programs.git = {
      enable = true;

      settings = {
        user.name = username;
        user.email = email;

        init.defaultBranch = "master";
        pull.rebase = false;
        push.autoSetupRemote = true;

        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        commit.gpgsign = true;

        alias = {
          st = "status";
          pu = "push";
          co = "checkout";
          br = "branch";
          cm = "commit -m";
          cam = "commit -am";
        };
      };
    };
  };
}
