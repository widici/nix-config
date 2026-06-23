{ inputs, system, username, email, path, ... }:

{ extraModules ? [] }:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  extraSpecialArgs = { inherit inputs username email path; };

  modules = [
    ../home
  ] ++ extraModules;
}
