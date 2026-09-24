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

    ruby-nix.url = "github:inscapist/ruby-nix";

    nixpkgs-ruby = {
      url = "github:bobvanderlinden/nixpkgs-ruby";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    bundix = {
      url = "github:inscapist/bundix/main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem =
        { system, ... }:
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

          bundix = inputs.bundix.packages.${system}.default;
        in
        {
          devShells.default = pkgs.mkShell {
            BUNDLE_PATH = "vendor/bundle";

            packages = [
              env
              bundix
            ];
          };
        };
    };
}
