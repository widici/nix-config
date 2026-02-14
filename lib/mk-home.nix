{ inputs, system, username, email, ... }:

{ extraModules ? [] }:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = { inherit inputs username email; };

  modules = [
    ../home-manager
  ] ++ extraModules;
}
