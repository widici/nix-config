{ inputs, vars, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = vars.username;
  };
}
