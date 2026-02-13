{ config, lib, ... }:

{
  options.system = {
    wsl.enable = lib.mkEnableOption "WSL config";
    users.enable = lib.mkEnableOption "Users config";
    initPkgs.enable = lib.mkEnableOption "Init pkgs config";
  };

  imports = [
    ./wsl.nix
    ./users.nix
    ./init-pkgs.nix
  ];

  config.system = {
    wsl.enable = lib.mkDefault false;
    users.enable = lib.mkDefault true;
    initPkgs.enable = lib.mkDefault true;
  };
}
