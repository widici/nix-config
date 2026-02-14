{ config, lib, inputs, username, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  options.system.wsl.enable = lib.mkEnableOption "WSL-specific config" // {
    default = true;
  };
  
  config = lib.mkIf config.system.wsl.enable {
    wsl = {
      enable = true;
      defaultUser = username;
    };
  };
}
