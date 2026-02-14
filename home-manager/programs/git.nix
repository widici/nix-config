{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "widici";
      user.email = "84205124+widici@users.noreply.github.com";

      init.defaultBranch = "master";
      pull.rebase = false; # Decide later
      push.autoSetupRemote = true;

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        cm = "commit -m";
        cam = "commit -am";
      };
    };
  };
}
