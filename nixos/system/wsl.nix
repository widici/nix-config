{ config, lib, inputs, username, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];
  
  config = lib.mkIf config.system.initPkgs.enable {
    wsl = {
      enable = true;
      defaultUser = username;
    };
  };
}
