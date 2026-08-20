{ vars, ... }:

{
  imports = [
    ../../nixos/profiles/wsl.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "ivar";
  system.stateVersion = "25.05";

  modules.nixos.cli.nh.enable = true;

  home-manager.users.${vars.username} = {
    imports = [
      ../../home/profiles/dev.nix
      ../../home/profiles/headless.nix
    ];

    modules.home = {
      cli.git.signing = {
        enable = true;
        key = "~/.ssh/id_ed25519.pub";
      };

      shells = {
        defaultShell = "fish";
        enabledShells = [
          "fish"
          "bash"
        ];
        starship.enable = true;
      };

      editors.tooling = {
        nix.enable = true;
      };

      styling.stylix = {
        enable = true;
      };
    };
  };
}
