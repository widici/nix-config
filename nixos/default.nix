{ inputs, username, email, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./system
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username email; };
    users.${username} = import ../home-manager;
  };
}
