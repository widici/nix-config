{
  description = "a minimal flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { pkgs, ... }: {
        packages.default = pkgs.writeShellScriptBin "program" ''${pkgs.cowsay}/bin/cowsay "hello world! :D"'';

        devShells.default = pkgs.mkShell {
          packages = [ pkgs.cowsay ];
        };
      };
    };
}
