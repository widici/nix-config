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
    
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    username = "widici";
    email = "84205124+${username}@users.noreply.github.com";
    path = "/home/${username}/nix-config";
    system = "x86_64-linux";
    hosts = ["ivar"];
    lib = import ./lib { inherit inputs system username email path; };
  in
  {
    nixosConfigurations = inputs.nixpkgs.lib.genAttrs hosts (hostname: lib.mkHost { inherit hostname; });
    homeConfigurations.${username} = lib.mkHome {};
  };
}
