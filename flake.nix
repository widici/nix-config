{
  description = "widici's NixOs config";
  
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {    
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        ./configuration.nix
      ];
    };
  };
}
