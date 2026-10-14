{ vars, ... }:

{
  imports = [
    ../../modules/nixos/profiles/minimal.nix
    ../../modules/nixos/profiles/wsl.nix
    ../../modules/nixos/profiles/qol.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "ivar";
  system.stateVersion = "25.05";

  home-manager.users.${vars.username} = {
    imports = [
      ../../modules/home/profiles/qol.nix
      ../../modules/home/profiles/dev.nix
      ../../modules/home/profiles/headless.nix
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
