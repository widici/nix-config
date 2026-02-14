{ inputs, system, ... }:

{
  mkHost = import ./mk-host.nix { inherit inputs system; };
  mkHome = import ./mk-home.nix { inherit inputs system; };
}
