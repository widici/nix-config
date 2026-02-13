{ config, lib, ... }:

{
  config = lib.mkIf config.system.initPkgs.enable {
    wsl = {
      enable = true;
      defaultUser = "widici";
    };
  };
}
