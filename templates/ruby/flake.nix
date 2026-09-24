{
  description = "a ruby-only flake";

  nixConfig = {
    extra-substituters = "https://nixpkgs-ruby.cachix.org";
    extra-trusted-public-keys = "nixpkgs-ruby.cachix.org-1:vrcdi50fTolOxWCZZkw0jakOnUI1T19oYJ+PRYdK4SM=";
  };

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

    ruby-nix.url = "github:inscapist/ruby-nix";

    nixpkgs-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs.nixpkgs-lib.follows = "nixpkgs";
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
            overlays = [ inputs.nixpkgs-ruby.overlays.default ];
          };

          # See available versions: https://github.com/bobvanderlinden/nixpkgs-ruby/blob/master/ruby/versions.json
          ruby = pkgs."ruby-latest";
          gemset = if builtins.pathExists ./gemset.nix then import ./gemset.nix else { };
          # See default: https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/ruby-modules/gem-config/default.nix
          gemConfig = { };

          inherit
            (
              (inputs.ruby-nix.lib pkgs {
                inherit ruby gemset;
                name = "project-name";
                gemConfig = pkgs.defaultGemConfig // gemConfig;
              })
            )
            env
            ;
        in
        {
          treefmt.config = {
            projectRootFile = "flake.nix";

            programs = {
              rubocop.enable = true;
            };
          };

          pre-commit.settings = {
            hooks.treefmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            BUNDLE_PATH = "vendor/bundle";

            inputsFrom = [
              config.pre-commit.devShell
              config.treefmt.build.devShell
            ];

            packages = [
              env
              ruby
              pkgs.ruby-lsp
            ];
          };
        };
    };
}
