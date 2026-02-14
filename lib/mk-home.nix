{ inputs, system, ... }:

{ extraModules ? [] }:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = { inherit inputs; };

  modules = [
    ../home-manager
  ] ++ extraModules;
}
