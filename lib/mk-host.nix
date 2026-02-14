{ inputs, system, ... }:

{ hostname, extraModules ? [] }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs; };

  modules = [
    ../nixos
    ../hosts/${hostname}
  ] ++ extraModules;
}
