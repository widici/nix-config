{ ... }:

{
  modules.home = {
    cli = {
      git.full.enable = true;
      oxidisation.enable = true;
    };

    editors = {
      helix.enable = true;
    };
  };
}
