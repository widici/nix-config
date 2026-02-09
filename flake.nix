{
  description = "widici's NixOs config";
  
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

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }: {
    nixosConfigurations.ivar = nixpkgs.lib.nixosSystem {    
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        home-manager.nixosModules.home-manager
        ./hosts/ivar
      ];
    };
  };
}
