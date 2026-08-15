{ vars, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = vars.path;
  };
}
