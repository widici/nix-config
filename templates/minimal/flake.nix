{
  description = "a minimal flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (sys:
      let
        pkgs = import nixpkgs { system = sys; };
        deps = [ pkgs.cowsay ];
        package = pkgs.writeShellScriptBin "program" ''${pkgs.cowsay}/bin/cowsay "hello world! :D"'';
      in {
        packages.default = package;
        devShells.default = pkgs.mkShell {
          packages = deps;
        };
      }
    );  
}
