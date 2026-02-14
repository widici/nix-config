{ inputs, system, username, email, ... }:

{ hostname, extraModules ? [] }:

inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs username email; };

  modules = [
    ../nixos
    ../hosts/${hostname}
  ] ++ extraModules;
}
