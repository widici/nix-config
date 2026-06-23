{ inputs, system, username, email, path, ... }:

{ hostname, extraModules ? [] }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs username email path; };

  modules = [
    ../nixos
    ../hosts/${hostname}
  ] ++ extraModules;
}
