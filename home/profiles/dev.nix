{ ... }:

{
  modules.home = {
    cli = {
      git.full.enable = true;
      oxidization.enable = true;
    };

    editors = {
      helix.enable = true;
    };
  };
}
