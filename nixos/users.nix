{ ... }:

{
  users.users.widici = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/widici";
  };

  security.sudo.enable = true;
}
