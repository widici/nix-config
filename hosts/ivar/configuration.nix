{ vars, ... }:

{
  imports = [
    ../../modules/nixos/profiles/minimal.nix
    ../../modules/nixos/profiles/qol.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "alvar";
  system.stateVersion = "26.05";

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.printing.enable = true;
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  virtualisation.virtualbox.guest.enable = true;

  home-manager.users.${vars.username} = {
    imports = [
      ../../modules/home/profiles/qol.nix
      ../../modules/home/profiles/dev.nix
    ];

    modules.home = {
      cli = {
        fun.enable = true;
        git.signing = {
          enable = true;
          key = "~/.ssh/id_ed25519.pub";
        };
      };

      shells = {
        defaultShell = "fish";
        enabledShells = [
          "fish"
          "bash"
        ];
        starship.enable = true;
      };

      styling.stylix = {
        enable = true;
      };
    };
  };
}
