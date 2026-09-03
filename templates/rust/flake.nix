{
  description = "a rust-only flake";

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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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

      perSystem =
        { config, system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ (import inputs.rust-overlay) ];
          };

          toolchain = pkgs.rust-bin.stable.latest.default.override {
            extensions = [
              "rust-src"
              "rust-analyzer"
            ];
          };

          platform = pkgs.makeRustPlatform {
            rustc = toolchain;
            cargo = toolchain;
          };

          cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
        in
        {
          _module.args.pkgs = pkgs;

          treefmt.config = {
            projectRootFile = "flake.nix";

            programs = {
              rustfmt.enable = true;
              taplo.enable = true;
            };
          };

          pre-commit.settings = {
            hooks.treefmt.enable = true;
          };

          packages.default = platform.buildRustPackage {
            name = cargoToml.package.name;
            src = ./.;
            cargoLock = {
              lockFile = ./Cargo.lock;
            };
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.pre-commit.devShell ];
            packages = [
              toolchain
              pkgs.taplo
            ];
          };
        };
    };
}
