{ inputs, system, username, ... }:

{
  mkHost = import ./mk-host.nix { inherit inputs system username; };
  mkHome = import ./mk-home.nix { inherit inputs system username; };
}
