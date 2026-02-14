{ inputs, system, username, ... }:

{ extraModules ? [] }:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = { inherit inputs username; };

  modules = [
    ../home-manager
  ] ++ extraModules;
}
