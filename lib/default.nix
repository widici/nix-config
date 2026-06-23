{ inputs, system, username, email, path,... }:

{
  mkHost = import ./mk-host.nix { inherit inputs system username email path; };
  mkHome = import ./mk-home.nix { inherit inputs system username email path; };
}
