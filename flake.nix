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
    homeConfig = import ./home-manager;
  in
  {
    nixosConfigurations.ivar = inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {inherit inputs;};     
      modules = [
        ./modules
        ./hosts/ivar
      ];
    };

    homeConfigurations.widici = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {inherit inputs;};
      modules = [ homeConfig ];
    };
  };
}
