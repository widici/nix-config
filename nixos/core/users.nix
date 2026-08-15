{
  pkgs,
  vars,
  ...
}:

{
  users.users.${vars.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/${vars.username}";

    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  security.sudo.enable = true;
}
