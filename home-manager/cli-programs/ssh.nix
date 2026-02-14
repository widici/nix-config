{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
         addKeysToAgent = "yes";
      };
      
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };

  services.ssh-agent = {
    enable = true;
  };
}
