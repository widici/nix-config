{
  description = "widici's nix config";
  
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    system = "x86_64-linux";
    username = "widici";
    hosts = ["ivar"];

    lib = import ./lib { inherit inputs system; };
  in
  {
    nixosConfigurations = inputs.nixpkgs.lib.genAttrs hosts (hostname: lib.mkHost { inherit hostname; });
    homeConfigurations.${username} = lib.mkHome {};
  };
}
