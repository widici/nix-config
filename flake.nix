{
  description = "widici's nix config";

  outputs =
    inputs:
    let
      vars = rec {
        username = "widici";
        email = "84205124+${username}@users.noreply.github.com";
        path = "/home/${username}/nix-config";
      };
      hosts = [ "ivar" ];
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks.flakeModule
      ];

      flake = {
        nixosConfigurations = inputs.nixpkgs.lib.genAttrs hosts (
          host:
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs vars; };
            modules = [
              ./nixos
              ./hosts/${host}/configuration.nix
            ];
          }
        );
      };

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
          packages = [ pkgs.nixd ];
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

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

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
