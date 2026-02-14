{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./system
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.widici = import ../home-manager;
  };

  system.stateVersion = "25.05";
}
