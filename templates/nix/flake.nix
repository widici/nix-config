{
  description = "a nix-only flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks.flakeModule
      ];

      perSystem = { config, pkgs, ... }: {
        treefmt.config = {
          projectRootFile = "flake.nix";

          programs = {
            nixfmt.enable = true;
            statix.enable = true;
            deadnix.enable = true;
          };
        };

        pre-commit.settings = {
          hooks.treefmt.enable = true;
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.pre-commit.devShell ];
        };
      };
    };
}
