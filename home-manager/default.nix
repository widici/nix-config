{ ... }:

{
  imports = [
    ./programs
  ];

  home.username = "widici";
  home.homeDirectory = "/home/widici";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
