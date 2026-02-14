{ inputs, system, username, ... }:

{ hostname, extraModules ? [] }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs username; };

  modules = [
    ../nixos
    ../hosts/${hostname}
  ] ++ extraModules;
}
