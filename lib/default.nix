{ inputs, system, username, email, ... }:

{
  mkHost = import ./mk-host.nix { inherit inputs system username email; };
  mkHome = import ./mk-home.nix { inherit inputs system username email; };
}
