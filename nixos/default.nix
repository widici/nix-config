{ ... }:

{
  imports = [
    ./core
    ./programs
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
